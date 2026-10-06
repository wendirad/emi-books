create schema if not exists private;

revoke all on schema private from public, anon, authenticated;

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  business_name text check (char_length(business_name) <= 120),
  first_name text check (char_length(first_name) <= 80),
  last_name text check (char_length(last_name) <= 80),
  photo_path text check (char_length(photo_path) <= 255),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.profiles is 'One row per auth user, created by the on_auth_user_created trigger.';
comment on column public.profiles.photo_path is 'Object path inside the profile-pictures storage bucket.';

create table public.admins (
  email text primary key check (email = lower(email))
);

comment on table public.admins is 'Lowercase emails of admin users. Rows are created with the service role or SQL, never by clients.';

alter table public.profiles enable row level security;
alter table public.profiles force row level security;
alter table public.admins enable row level security;
alter table public.admins force row level security;

revoke all on public.profiles from anon, authenticated;
revoke all on public.admins from anon, authenticated;

grant select on public.profiles to authenticated;
grant update (business_name, first_name, last_name, photo_path)
  on public.profiles to authenticated;
grant select on public.admins to authenticated;

create policy profiles_select_own on public.profiles
  for select to authenticated
  using ((select auth.uid()) = id);

create policy profiles_update_own on public.profiles
  for update to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

create policy admins_select_own_email on public.admins
  for select to authenticated
  using (email = lower((select auth.jwt() ->> 'email')));

create function private.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function private.set_updated_at();

create function private.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.profiles (id, business_name)
  values (new.id, nullif(trim(new.raw_user_meta_data ->> 'business_name'), ''));
  return new;
end;
$$;

revoke execute on function private.set_updated_at() from public, anon, authenticated;
revoke execute on function private.handle_new_user() from public, anon, authenticated;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function private.handle_new_user();
