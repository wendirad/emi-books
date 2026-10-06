import http from 'node:http';
import { createRemoteJWKSet, jwtVerify } from 'jose';

const projectNumber = process.env.FIREBASE_PROJECT_NUMBER;
const port = Number(process.env.PORT ?? 3000);
const enforce = (process.env.APP_CHECK_ENFORCE ?? 'true') === 'true';
const jwksUrl =
  process.env.APP_CHECK_JWKS_URL ??
  'https://firebaseappcheck.googleapis.com/v1/jwks';

if (!projectNumber) {
  console.error('FIREBASE_PROJECT_NUMBER is required');
  process.exit(1);
}

const jwks = createRemoteJWKSet(new URL(jwksUrl));

async function isValid(token) {
  try {
    const { payload } = await jwtVerify(token, jwks, {
      issuer: `https://firebaseappcheck.googleapis.com/${projectNumber}`,
      audience: `projects/${projectNumber}`,
      algorithms: ['RS256'],
      typ: 'JWT',
    });
    return Boolean(payload.sub);
  } catch (error) {
    console.warn(`rejected token: ${error.code ?? error.message}`);
    return false;
  }
}

export const server = http.createServer(async (req, res) => {
  if (req.url === '/healthz') {
    res.writeHead(200).end('ok');
    return;
  }

  const token = req.headers['x-firebase-appcheck'];
  const valid = typeof token === 'string' && token !== '' && (await isValid(token));

  if (valid || !enforce) {
    res.writeHead(204).end();
    return;
  }

  res.writeHead(401).end();
});

if (process.argv[1] === new URL(import.meta.url).pathname) {
  server.listen(port, () => {
    console.log(`app check verifier on :${port} (enforce=${enforce})`);
  });
}
