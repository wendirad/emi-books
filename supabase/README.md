# Supabase

## Layout
- `migrations/` holds the SQL applied to the database, in timestamp order.
- `tests/policies.test.sql` checks the table policies, grants and triggers.
- `tests/storage.test.sql` checks the `profile-pictures` bucket settings and
  its storage policies.

Each test runs in one transaction and rolls back, so it leaves no data behind.

## Apply a migration
```
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f migrations/<file>.sql
```
`DATABASE_URL` is the direct Postgres connection string of the Supabase
instance, with a role that owns the schema (`postgres` or `supabase_admin`).

## Run the policy tests
```
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f tests/policies.test.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f tests/storage.test.sql
```
The last line printed is `all policy tests passed` and `all storage tests passed`. Any failure aborts with
`FAILED: <what was checked>`. Run against a staging copy, since the test
inserts rows into `auth.users` inside its transaction.

## Tables
| Table | Purpose | Client access |
|---|---|---|
| `public.profiles` | One row per auth user, created by a trigger on `auth.users` | Select own row, update `business_name`, `first_name`, `last_name`, `photo_path` of own row |
| `public.admins` | Lowercase admin emails | Select the row matching the JWT email, no writes |

`business_name` is read from the `business_name` key of the sign up user
metadata. Add an admin with SQL or the service role:
```
insert into public.admins (email) values ('person@example.com');
```

## Storage
| Bucket | Access | Limits |
|---|---|---|
| `profile-pictures` | Private. Any signed in user reads, a user writes only under `<uid>/` | 5 MB, `image/*` |

Objects are stored as `<uid>/profile.<ext>` and `profiles.photo_path` holds that
path. The app reads photos through signed URLs.
