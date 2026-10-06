insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('profile-pictures', 'profile-pictures', false, 5242880, array['image/*'])
on conflict (id) do update set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

create policy profile_pictures_select on storage.objects
  for select to authenticated
  using (bucket_id = 'profile-pictures');

create policy profile_pictures_insert_own on storage.objects
  for insert to authenticated
  with check (
    bucket_id = 'profile-pictures'
    and (storage.foldername(name))[1] = (select auth.uid())::text
  );

create policy profile_pictures_update_own on storage.objects
  for update to authenticated
  using (
    bucket_id = 'profile-pictures'
    and (storage.foldername(name))[1] = (select auth.uid())::text
  )
  with check (
    bucket_id = 'profile-pictures'
    and (storage.foldername(name))[1] = (select auth.uid())::text
  );

create policy profile_pictures_delete_own on storage.objects
  for delete to authenticated
  using (
    bucket_id = 'profile-pictures'
    and (storage.foldername(name))[1] = (select auth.uid())::text
  );
