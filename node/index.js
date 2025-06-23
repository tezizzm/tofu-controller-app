const express = require('express');
const { Client } = require('pg');

const app = express();
const port = process.env.PORT || 3000;

// Read DB connection from env vars
const client = new Client({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

client.connect()
  .then(() => console.log('✅ Connected to Postgres'))
  .catch(err => {
    console.error('❌ Postgres connection error:', err.stack);
    process.exit(1);
  });

app.get('/', async (req, res) => {
  const result = await client.query('SELECT NOW()');
  res.send(`Hello! Postgres time is ${result.rows[0].now}`);
});

app.listen(port, () => {
  console.log(`🚀 App listening on port ${port}`);
});