const { test, before, after, beforeEach } = require('node:test');
const fs = require('node:fs');
const path = require('node:path');
const {
  initializeTestEnvironment,
  assertFails,
  assertSucceeds,
} = require('@firebase/rules-unit-testing');
const { doc, getDoc, setDoc, updateDoc, deleteDoc } = require('firebase/firestore');

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-rules-test',
    firestore: {
      host: '127.0.0.1',
      port: 8080,
      rules: fs.readFileSync(path.join(__dirname, '../firestore.rules'), 'utf8'),
    },
  });
});

after(async () => env.cleanup());
beforeEach(async () => env.clearFirestore());

const alice = () => env.authenticatedContext('alice', { email: 'alice@example.com' }).firestore();
const bob = () => env.authenticatedContext('bob', { email: 'bob@example.com' }).firestore();
const anon = () => env.unauthenticatedContext().firestore();

test('a user reads and writes their own profile', async () => {
  await assertSucceeds(setDoc(doc(alice(), 'user/alice'), { firstName: 'Alice' }));
  await assertSucceeds(getDoc(doc(alice(), 'user/alice')));
  await assertSucceeds(updateDoc(doc(alice(), 'user/alice'), { firstName: 'Al' }));
});

test('a user cannot read, write or delete another profile', async () => {
  await env.withSecurityRulesDisabled((ctx) =>
    setDoc(doc(ctx.firestore(), 'user/alice'), { firstName: 'Alice' }),
  );
  await assertFails(getDoc(doc(bob(), 'user/alice')));
  await assertFails(setDoc(doc(bob(), 'user/alice'), { firstName: 'Mallory' }));
  await assertFails(deleteDoc(doc(bob(), 'user/alice')));
});

test('signed-out clients cannot touch profiles', async () => {
  await assertFails(getDoc(doc(anon(), 'user/alice')));
  await assertFails(setDoc(doc(anon(), 'user/alice'), { firstName: 'x' }));
});

test('a user can look up their own admin flag only', async () => {
  await assertSucceeds(getDoc(doc(alice(), 'admin/alice@example.com')));
  await assertFails(getDoc(doc(alice(), 'admin/bob@example.com')));
  await assertFails(getDoc(doc(anon(), 'admin/alice@example.com')));
});

test('clients can never write an admin flag', async () => {
  await assertFails(setDoc(doc(alice(), 'admin/alice@example.com'), { isAdmin: true }));
});

test('every other collection is closed', async () => {
  await assertFails(getDoc(doc(alice(), 'orders/1')));
  await assertFails(setDoc(doc(alice(), 'orders/1'), { total: 1 }));
});
