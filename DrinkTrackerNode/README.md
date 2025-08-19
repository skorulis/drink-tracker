## DrinkTracker API

Node/Express API with Apple Sign In and Postgres.

### Setup

1) Install deps
```
yarn
```

2) Configure environment (copy and edit)
```
touch .env
```

Set:
- `APPLE_AUDIENCE` = your iOS bundle id
- `JWT_SECRET` = long random string
- `DATABASE_URL`

3) Local Postgres (optional)
```
docker compose up -d db
```

4) Start API
```
yarn start
```

### API

- `POST /auth/apple` body `{ identityToken }` → `{ token, user }`
- `GET /me` `Authorization: Bearer <token>` → `{ user }`

