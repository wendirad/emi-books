# App Check verifier

Small service that nginx calls before forwarding a request to self-hosted
Supabase. It checks the Firebase App Check token the app sends in the
`X-Firebase-AppCheck` header and answers `204` (valid) or `401` (missing or
invalid). The app side is `AppCheckHttpClient` in `lib/src/core/utils/`.

```
app -> nginx -- auth_request --> verifier (this folder)
         |
         +-- 204 --> Supabase gateway (Kong)
         +-- 401 --> client gets 401
```

## What you need
- Docker with Compose, and nginx with `ngx_http_auth_request_module` (included
  in the standard Debian, Ubuntu and official nginx builds).
- The Firebase project number: `project_number` in
  `android/app/google-services.json`.

## Setup
1. `cd appCheck && cp .env.example .env` and set `FIREBASE_PROJECT_NUMBER`.
2. `docker compose up -d --build`
3. `curl http://127.0.0.1:3100/healthz` returns `ok`.
4. Copy `nginx/app-check.conf` to
   `/etc/nginx/snippets/`. In `app-check.conf`, `127.0.0.1:3100` is the
   verifier (change it if nginx runs in Docker, for example to
   `http://app-check-verifier:3000`) and `127.0.0.1:8000` is the Supabase
   gateway (Kong). Add
   `include /etc/nginx/snippets/app-check.conf;` inside the Supabase `server`
   block. Remove any existing `location` for `/auth/v1/`, `/rest/v1/` and
   `/storage/v1/` first, or keep your own `proxy_pass` settings and only add the
   `auth_request /_app_check;` line to them.
5. `nginx -t && nginx -s reload`

## Environment
| Variable | Default | Meaning |
|---|---|---|
| `FIREBASE_PROJECT_NUMBER` | none, required | Used for the token issuer and audience |
| `APP_CHECK_ENFORCE` | `true` | `false` lets all requests through and only logs rejected tokens |
| `VERIFIER_PORT` | `3100` | Host port, bound to `127.0.0.1` only |

Roll out with `APP_CHECK_ENFORCE=false` first, watch `docker logs
app-check-verifier` for `rejected token` lines from real devices, then set it
to `true` and run `docker compose up -d`.

## Check it
```
curl -i https://<host>/rest/v1/                                  # 401
curl -i -H "X-Firebase-AppCheck: junk" https://<host>/rest/v1/   # 401
```
A debug build with a registered debug token (Firebase console, App Check,
Manage debug tokens) must reach Supabase normally.

## Must do on the server
- Do not expose the Supabase gateway port, Studio or Postgres to the internet.
  nginx must be the only public way in, or this check can be skipped.
- Image URLs loaded by `Image.network` carry no header. Signed storage URLs
  (`/storage/v1/object/sign/`) skip the check in `nginx/app-check.conf`
  because the URL itself holds a time limited token. Buckets stay private.

## Tests
`npm ci && npm test` runs the verifier against a locally generated key pair.
