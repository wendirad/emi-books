import assert from 'node:assert/strict';
import http from 'node:http';
import { after, before, test } from 'node:test';
import { SignJWT, exportJWK, generateKeyPair } from 'jose';

const projectNumber = '123456';
let jwksServer;
let verifier;
let privateKey;
let base;

async function signToken({ issuer, audience, expiresIn = '1h' }) {
  return new SignJWT({})
    .setProtectedHeader({ alg: 'RS256', typ: 'JWT', kid: 'k1' })
    .setSubject('1:123456:android:abc')
    .setIssuer(issuer)
    .setAudience(audience)
    .setIssuedAt()
    .setExpirationTime(expiresIn)
    .sign(privateKey);
}

before(async () => {
  const pair = await generateKeyPair('RS256');
  privateKey = pair.privateKey;
  const jwk = { ...(await exportJWK(pair.publicKey)), kid: 'k1', alg: 'RS256' };

  jwksServer = http.createServer((_, res) => {
    res.setHeader('content-type', 'application/json');
    res.end(JSON.stringify({ keys: [jwk] }));
  });
  await new Promise((r) => jwksServer.listen(0, '127.0.0.1', r));

  process.env.FIREBASE_PROJECT_NUMBER = projectNumber;
  process.env.APP_CHECK_JWKS_URL = `http://127.0.0.1:${jwksServer.address().port}/`;
  ({ server: verifier } = await import('../server.mjs'));
  await new Promise((r) => verifier.listen(0, '127.0.0.1', r));
  base = `http://127.0.0.1:${verifier.address().port}`;
});

after(() => {
  verifier.close();
  jwksServer.close();
});

const call = (token) =>
  fetch(base, { headers: token ? { 'X-Firebase-AppCheck': token } : {} });

test('healthz answers 200', async () => {
  assert.equal((await fetch(`${base}/healthz`)).status, 200);
});

test('rejects a missing token', async () => {
  assert.equal((await call()).status, 401);
});

test('rejects a malformed token', async () => {
  assert.equal((await call('junk')).status, 401);
});

test('rejects a token for another project', async () => {
  const token = await signToken({
    issuer: 'https://firebaseappcheck.googleapis.com/999',
    audience: 'projects/999',
  });
  assert.equal((await call(token)).status, 401);
});

test('rejects an expired token', async () => {
  const token = await signToken({
    issuer: `https://firebaseappcheck.googleapis.com/${projectNumber}`,
    audience: `projects/${projectNumber}`,
    expiresIn: '-1h',
  });
  assert.equal((await call(token)).status, 401);
});

test('accepts a valid token', async () => {
  const token = await signToken({
    issuer: `https://firebaseappcheck.googleapis.com/${projectNumber}`,
    audience: `projects/${projectNumber}`,
  });
  assert.equal((await call(token)).status, 204);
});
