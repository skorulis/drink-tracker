require("dotenv").config();
const express = require("express");
const jwt = require("jsonwebtoken");
const jwksClient = require("jwks-rsa");
const app = express();
const port = process.env.PORT || 3001;

// Parse JSON request bodies
app.use(express.json());

// Apple JWKS client for verifying Apple ID identity tokens
const appleJwksClient = jwksClient({
  jwksUri: "https://appleid.apple.com/auth/keys",
  cache: true,
  rateLimit: true,
  jwksRequestsPerMinute: 10,
});

function getAppleSigningKey(header, callback) {
  appleJwksClient.getSigningKey(header.kid, function (err, key) {
    if (err) return callback(err);
    const signingKey = key.getPublicKey();
    return callback(null, signingKey);
  });
}

function verifyAppleIdentityToken(identityToken) {
  console.log(`Verify for ${process.env.APPLE_AUDIENCE}`)
  return new Promise((resolve, reject) => {
    jwt.verify(
      identityToken,
      getAppleSigningKey,
      {
        algorithms: ["RS256"],
        issuer: "https://appleid.apple.com",
        audience: process.env.APPLE_AUDIENCE,
      },
      (error, payload) => {
        if (error) return reject(error);
        return resolve(payload);
      }
    );
  });
}

// Simple session auth middleware using our own JWTs
function authenticateSession(req, res, next) {
  const authHeader = req.headers["authorization"] || "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : null;
  if (!token) return res.status(401).json({ error: "Missing Authorization header" });
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.auth = decoded;
    return next();
  } catch (error) {
    return res.status(401).json({ error: "Invalid or expired token" });
  }
}

app.get("/", (req, res) => {
  res.json({
    message: "Hello from DrinkTracker API!",
    timestamp: new Date().toISOString(),
    status: "success"
  });
});

// Exchange Apple identity token for an app session token
app.post("/auth/apple", async (req, res) => {
  try {
    const { identityToken } = req.body || {};
    if (!identityToken) return res.status(400).json({ error: "identityToken is required" });

    const applePayload = await verifyAppleIdentityToken(identityToken);
    const userId = applePayload.sub;
    const email = applePayload.email;

    // Issue app session token
    const sessionToken = jwt.sign(
      { userId, email, provider: "apple" },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    return res.json({
      token: sessionToken,
      user: { id: userId, email },
      providerPayload: { iss: applePayload.iss, aud: applePayload.aud, iat: applePayload.iat, exp: applePayload.exp },
    });
  } catch (error) {
    return res.status(401).json({ error: "Invalid Apple identity token" });
  }
});

// Example protected route
app.get("/me", authenticateSession, (req, res) => {
  return res.json({ user: { id: req.auth.userId, email: req.auth.email }, auth: req.auth });
});

const server = app.listen(port, () => console.log(`DrinkTracker API listening on port ${port}!`));

server.keepAliveTimeout = 120 * 1000;
server.headersTimeout = 120 * 1000;
