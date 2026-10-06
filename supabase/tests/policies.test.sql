begin;

create function pg_temp.assert(condition boolean, message text)
returns void
language plpgsql
as $$
begin
  if condition is not true then
    raise exception 'FAILED: %', message;
  end if;
end;
$$;

create function pg_temp.denied(stmt text)
returns boolean
language plpgsql
as $$
begin
  execute stmt;
  return false;
exception
  when insufficient_privilege then
    return true;
end;
$$;

create function pg_temp.act_as(user_id uuid, user_email text)
returns void
language plpgsql
as $$
begin
  perform set_config(
    'request.jwt.claims',
    json_build_object('sub', user_id, 'email', user_email, 'role', 'authenticated')::text,
    true
  );
  execute 'set local role authenticated';
end;
$$;

insert into auth.users (id, email, raw_user_meta_data) values
  ('00000000-0000-0000-0000-00000000000a', 'a@example.com', '{"business_name": "  Acme  "}'),
  ('00000000-0000-0000-0000-00000000000b', 'b@example.com', '{}');

insert into public.admins (email) values ('a@example.com');

do $$
begin
  perform pg_temp.assert(
    (select business_name from public.profiles where id = '00000000-0000-0000-0000-00000000000a') = 'Acme',
    'sign up creates a profile with the trimmed business name'
  );
  perform pg_temp.assert(
    (select business_name from public.profiles where id = '00000000-0000-0000-0000-00000000000b') is null,
    'sign up without metadata creates a profile with no business name'
  );
end;
$$;

do $$
declare
  affected integer;
begin
  perform pg_temp.act_as('00000000-0000-0000-0000-00000000000a', 'a@example.com');

  perform pg_temp.assert((select count(*) from public.profiles) = 1, 'a user sees only one profile');
  perform pg_temp.assert(
    (select id from public.profiles) = '00000000-0000-0000-0000-00000000000a',
    'a user sees their own profile'
  );

  update public.profiles set first_name = 'Abebe' where id = '00000000-0000-0000-0000-00000000000a';
  get diagnostics affected = row_count;
  perform pg_temp.assert(affected = 1, 'a user updates their own profile');

  update public.profiles set first_name = 'Hacked' where id = '00000000-0000-0000-0000-00000000000b';
  get diagnostics affected = row_count;
  perform pg_temp.assert(affected = 0, 'a user cannot update another profile');

  perform pg_temp.assert(
    pg_temp.denied($q$update public.profiles set id = gen_random_uuid()$q$),
    'a user cannot change the profile id'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$update public.profiles set created_at = now()$q$),
    'a user cannot change created_at'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$insert into public.profiles (id) values (gen_random_uuid())$q$),
    'a user cannot insert a profile'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$delete from public.profiles$q$),
    'a user cannot delete a profile'
  );

  perform pg_temp.assert((select count(*) from public.admins) = 1, 'an admin sees their own admin row');
  perform pg_temp.assert(
    pg_temp.denied($q$insert into public.admins (email) values ('c@example.com')$q$),
    'a user cannot insert an admin'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$update public.admins set email = 'c@example.com'$q$),
    'a user cannot update an admin'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$delete from public.admins$q$),
    'a user cannot delete an admin'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$select private.handle_new_user()$q$),
    'a user cannot call private functions'
  );

  reset role;
end;
$$;

do $$
begin
  perform pg_temp.act_as('00000000-0000-0000-0000-00000000000b', 'B@Example.com');

  perform pg_temp.assert((select count(*) from public.admins) = 0, 'a non admin sees no admin rows');
  perform pg_temp.assert(
    (select first_name from public.profiles) is null,
    'a user does not see changes made to another profile'
  );

  reset role;

  perform pg_temp.act_as('00000000-0000-0000-0000-00000000000b', 'A@Example.com');
  perform pg_temp.assert((select count(*) from public.admins) = 1, 'admin email matching ignores case');

  reset role;
end;
$$;

do $$
begin
  perform set_config('request.jwt.claims', '{"role": "anon"}', true);
  execute 'set local role anon';

  perform pg_temp.assert(pg_temp.denied('select * from public.profiles'), 'anon cannot read profiles');
  perform pg_temp.assert(pg_temp.denied('select * from public.admins'), 'anon cannot read admins');

  reset role;
end;
$$;

do $$
declare
  before_update timestamptz := now() - interval '1 day';
begin
  set local session_replication_role = replica;
  update public.profiles set updated_at = before_update
    where id = '00000000-0000-0000-0000-00000000000a';
  set local session_replication_role = origin;

  perform pg_temp.act_as('00000000-0000-0000-0000-00000000000a', 'a@example.com');
  update public.profiles set last_name = 'Kebede'
    where id = '00000000-0000-0000-0000-00000000000a';
  reset role;

  perform pg_temp.assert(
    (select updated_at from public.profiles where id = '00000000-0000-0000-0000-00000000000a') > before_update,
    'updating a profile refreshes updated_at'
  );
end;
$$;

do $$
begin
  delete from auth.users where id = '00000000-0000-0000-0000-00000000000a';
  perform pg_temp.assert(
    not exists (select 1 from public.profiles where id = '00000000-0000-0000-0000-00000000000a'),
    'deleting an auth user deletes the profile'
  );
end;
$$;

select 'all policy tests passed' as result;

rollback;
