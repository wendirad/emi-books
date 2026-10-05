const { test, before, after } = require('node:test');
const fs = require('node:fs');
const path = require('node:path');
const {
  initializeTestEnvironment,
  assertFails,
  assertSucceeds,
} = require('@firebase/rules-unit-testing');
const { ref, uploadBytes, getBytes, deleteObject } = require('firebase/storage');

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-rules-test',
    storage: {
      host: '127.0.0.1',
      port: 9199,
      rules: fs.readFileSync(path.join(__dirname, '../storage.rules'), 'utf8'),
    },
  });
});

after(async () => env.cleanup());

const alice = () => env.authenticatedContext('alice').storage();
const bob = () => env.authenticatedContext('bob').storage();
const anon = () => env.unauthenticatedContext().storage();
const photo = (name) => `images/profile_picture/${name}`;
const png = { contentType: 'image/png' };
const bytes = (n = 10) => new Uint8Array(n);

test('a user uploads, replaces and deletes their own photo', async () => {
  await assertSucceeds(uploadBytes(ref(alice(), photo('alice.png')), bytes(), png));
  await assertSucceeds(uploadBytes(ref(alice(), photo('alice.png')), bytes(20), png));
  await assertSucceeds(deleteObject(ref(alice(), photo('alice.png'))));
});

test('a user cannot write or delete another user\'s photo', async () => {
  await env.withSecurityRulesDisabled((ctx) =>
    uploadBytes(ref(ctx.storage(), photo('alice.png')), bytes(), png),
  );
  await assertFails(uploadBytes(ref(bob(), photo('alice.png')), bytes(), png));
  await assertFails(deleteObject(ref(bob(), photo('alice.png'))));
});

test('a photo must be an image under 5 MB', async () => {
  await assertFails(
    uploadBytes(ref(alice(), photo('alice.txt')), bytes(), { contentType: 'text/plain' }),
  );
  await assertFails(
    uploadBytes(ref(alice(), photo('alice.png')), bytes(5 * 1024 * 1024 + 1), png),
  );
});

test('signed-in users can read photos, signed-out cannot', async () => {
  await env.withSecurityRulesDisabled((ctx) =>
    uploadBytes(ref(ctx.storage(), photo('alice.png')), bytes(), png),
  );
  await assertSucceeds(getBytes(ref(bob(), photo('alice.png'))));
  await assertFails(getBytes(ref(anon(), photo('alice.png'))));
});

test('nothing outside the profile photo folder is open', async () => {
  await assertFails(uploadBytes(ref(alice(), 'other/alice.png'), bytes(), png));
  await assertFails(uploadBytes(ref(alice(), 'images/alice.png'), bytes(), png));
});
