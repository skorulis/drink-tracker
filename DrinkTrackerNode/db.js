const { Pool } = require("pg");

function buildPoolConfig() {
  const hasDatabaseUrl = !!process.env.DATABASE_URL;
  const shouldUseSsl = (
    process.env.DATABASE_SSL === "true" ||
    process.env.PGSSLMODE === "require" ||
    (process.env.NODE_ENV === "production" && hasDatabaseUrl)
  );

  const ssl = shouldUseSsl ? { rejectUnauthorized: false } : undefined;

  if (hasDatabaseUrl) {
    return { connectionString: process.env.DATABASE_URL, ssl };
  }

  return {
    host: process.env.PGHOST || "127.0.0.1",
    port: Number(process.env.PGPORT || 5432),
    user: process.env.PGUSER || "postgres",
    password: process.env.PGPASSWORD || "postgres",
    database: process.env.PGDATABASE || "drinktracker",
    ssl,
  };
}

const pool = new Pool(buildPoolConfig());

async function init() {
  await pool.query(`
    create table if not exists users (
      id text primary key,
      email text,
      provider text not null,
      created_at timestamptz not null default now(),
      updated_at timestamptz not null default now(),
      last_login_at timestamptz
    );
    create index if not exists idx_users_email on users (email);
  `);
}

async function upsertUserApple(userId, email) {
  const result = await pool.query(
    `
    insert into users (id, email, provider, created_at, updated_at, last_login_at)
    values ($1, $2, 'apple', now(), now(), now())
    on conflict (id) do update set
      email = excluded.email,
      updated_at = now(),
      last_login_at = now()
    returning id, email, provider, created_at, updated_at, last_login_at;
    `,
    [userId, email || null]
  );
  return result.rows[0];
}

async function getUserById(userId) {
  const result = await pool.query(
    `select id, email, provider, created_at, updated_at, last_login_at from users where id = $1`,
    [userId]
  );
  return result.rows[0] || null;
}

module.exports = {
  pool,
  init,
  upsertUserApple,
  getUserById,
};


