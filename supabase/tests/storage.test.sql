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

insert into storage.buckets (id, name) values ('other-bucket', 'other-bucket')
on conflict (id) do nothing;

insert into storage.objects (bucket_id, name) values
  ('profile-pictures', '00000000-0000-0000-0000-00000000000b/profile.png');

do $$
declare
  settings record;
begin
  select public, file_size_limit, allowed_mime_types into settings
    from storage.buckets where id = 'profile-pictures';

  perform pg_temp.assert(settings.public = false, 'the bucket is private');
  perform pg_temp.assert(settings.file_size_limit = 5242880, 'the bucket limits files to 5 MB');
  perform pg_temp.assert(settings.allowed_mime_types = array['image/*'], 'the bucket accepts images only');
end;
$$;

do $$
declare
  affected integer;
begin
  perform pg_temp.act_as('00000000-0000-0000-0000-00000000000a', 'a@example.com');

  insert into storage.objects (bucket_id, name)
    values ('profile-pictures', '00000000-0000-0000-0000-00000000000a/profile.png');

  perform pg_temp.assert(
    pg_temp.denied($q$insert into storage.objects (bucket_id, name) values ('profile-pictures', '00000000-0000-0000-0000-00000000000b/hack.png')$q$),
    'a user cannot upload into another user folder'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$insert into storage.objects (bucket_id, name) values ('profile-pictures', 'loose.png')$q$),
    'a user cannot upload outside a user folder'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$insert into storage.objects (bucket_id, name) values ('other-bucket', '00000000-0000-0000-0000-00000000000a/profile.png')$q$),
    'a user cannot upload into another bucket'
  );

  perform pg_temp.assert(
    (select count(*) from storage.objects where bucket_id = 'profile-pictures') = 2,
    'a user reads photos of every user'
  );

  update storage.objects set name = '00000000-0000-0000-0000-00000000000a/new.png'
    where name = '00000000-0000-0000-0000-00000000000a/profile.png';
  get diagnostics affected = row_count;
  perform pg_temp.assert(affected = 1, 'a user replaces their own photo');

  perform pg_temp.assert(
    pg_temp.denied($q$update storage.objects set name = '00000000-0000-0000-0000-00000000000b/stolen.png' where name = '00000000-0000-0000-0000-00000000000a/new.png'$q$),
    'a user cannot move their photo into another folder'
  );

  update storage.objects set name = 'x.png'
    where name = '00000000-0000-0000-0000-00000000000b/profile.png';
  get diagnostics affected = row_count;
  perform pg_temp.assert(affected = 0, 'a user cannot update another photo');

  delete from storage.objects where name = '00000000-0000-0000-0000-00000000000b/profile.png';
  get diagnostics affected = row_count;
  perform pg_temp.assert(affected = 0, 'a user cannot delete another photo');

  delete from storage.objects where name = '00000000-0000-0000-0000-00000000000a/new.png';
  get diagnostics affected = row_count;
  perform pg_temp.assert(affected = 1, 'a user deletes their own photo');

  reset role;
end;
$$;

do $$
begin
  perform set_config('request.jwt.claims', '{"role": "anon"}', true);
  execute 'set local role anon';

  perform pg_temp.assert(
    (select count(*) from storage.objects where bucket_id = 'profile-pictures') = 0,
    'anon cannot read photos'
  );
  perform pg_temp.assert(
    pg_temp.denied($q$insert into storage.objects (bucket_id, name) values ('profile-pictures', '00000000-0000-0000-0000-00000000000a/anon.png')$q$),
    'anon cannot upload'
  );

  reset role;
end;
$$;

select 'all storage tests passed' as result;

rollback;
