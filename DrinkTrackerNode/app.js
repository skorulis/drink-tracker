const express = require("express");
const app = express();
const port = process.env.PORT || 3001;

app.get("/", (req, res) => {
  res.json({
    message: "Hello from DrinkTracker API!",
    timestamp: new Date().toISOString(),
    status: "success"
  });
});

const server = app.listen(port, () => console.log(`DrinkTracker API listening on port ${port}!`));

server.keepAliveTimeout = 120 * 1000;
server.headersTimeout = 120 * 1000;
