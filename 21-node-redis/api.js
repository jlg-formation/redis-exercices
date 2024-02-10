const express = require("express");
const axios = require("axios").default;

const redis = require("redis");

const { createClient } = redis;

let client;
(async () => {
  client = await createClient({
    url: "redis://localhost:7000",
  })
    .on("error", (err) => console.log("Redis Client Error", err))
    .connect();
})();

const app = express.Router();

const url = "https://api.github.com/users";

app.get("/users", (req, res) => {
  (async () => {
    console.time();
    const value = await client.get(url);
    if (value === null) {
      const result = await axios.get(url);
      await client.set(url, JSON.stringify(result.data), { EX: 10 });
      console.timeEnd();
      res.json(result.data);
      return;
    }
    const data = JSON.parse(value);
    console.timeEnd();
    res.json(data);
  })();
});

module.exports = app;
