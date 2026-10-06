# Status

Project state. Do not read or edit this file whole: use `bash tool/status.sh` (see `AGENTS.md`).

## Format

One line per item, so a single `grep` finds it.

- Feature row: `| F-<name> | <Feature> | <state> | <notes> |` in the table below. States: `done`, `partial`, `placeholder`, `untested`, `todo`.
- Task: `- [<mark>] T<nnn> <area>: <title>`. Marks: `[ ]` todo, `[~]` in progress, `[x]` done, `[!]` blocked (reason in the title).
- Subtask: indented under its task as `  - [<mark>] T<nnn>.<n> <title>`.
- `<area>` is the feature or layer: `auth`, `profile`, `settings`, `core`, `l10n`, `theme`, `app`.
- Finished top-level tasks move to `docs/status/archive.md` with `bash tool/status.sh archive`.

## Features

| ID | Feature | State | Notes |
|---|---|---|---|
| F-shell | App shell: splash, nav bar, connection banner, error views | done | `lib/src/app` |
| F-auth | Auth: sign up, sign in, sign out, password reset, session guard, remembered email | done | `modules/auth` |
| F-profile | Profile: edit name and photo | done | `modules/profile` |
| F-settings | Settings: theme, language, privacy and terms links, About | done | links come from `.env` |
| F-theme | Theme: light, dark, system | done | `core/theme` |
| F-l10n | Localization: English, Amharic | done | Amharic reviewed |
| F-home | Home tab | placeholder | shows the word "Home" |
| F-rules | Firestore and Storage rules | tested | `firestore.rules`, `storage.rules` |
| F-tests | Screen and repository tests | partial | `AppButton` and `AuthFooter` only |

## Tasks

- [ ] T003 app: build the Home tab
- [ ] T004 auth: widget tests for the sign-in and sign-up screens
- [ ] T005 settings: widget tests for the settings screen
- [ ] T006 profile: widget tests for the edit-profile screen
- [ ] T007 auth: repository tests for `AuthRepository` and `ProfileRepository` with fakes
- [~] T008 core: migrate Firebase auth, Firestore and Storage to self-hosted Supabase (keep App Check) (epic #10)
  - [x] T008.1 starter: Supabase init, env keys, client bind
  - [ ] T008.2 move auth to Supabase Auth (#6)
  - [ ] T008.3 move profile data to a Supabase table with RLS and migration (#4)
  - [ ] T008.4 move profile photo to Supabase Storage (#5)
  - [ ] T008.5 remove Firebase auth, Firestore, Storage, rules and rules_test (#9)
  - [x] T008.6 keep App Check and send its token to Supabase (#3)
- [ ] T009 auth: low priority: require email confirmation on sign up (#7)
- [ ] T010 auth: low priority: phone number OTP sign in (#8)
- [ ] T011 core: low priority: support websites behind the App Check proxy (#11)
