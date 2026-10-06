# emi_books

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Environment

`.env` is bundled into the app. Put configuration only, never secrets.

| Key | Purpose |
|---|---|
| `supabaseUrl` | Base URL of the Supabase instance |
| `supabaseAnonKey` | Public anon key of the instance, never the service role key |
| `androidDebugToken` | Firebase App Check debug token, debug builds on Android |
| `appleDebugToken` | Firebase App Check debug token, debug builds on iOS |

## App Check

Firebase App Check stays on for Supabase requests. The app sends the token in
the `X-Firebase-AppCheck` header on every call (`AppCheckHttpClient`). The
server side check that rejects requests without a valid token lives in
[`appCheck/`](appCheck/README.md), with its Docker Compose file, env and nginx
config. In debug builds register the token printed by the debug provider under
App Check in the Firebase console and set it as `androidDebugToken` or
`appleDebugToken`.
