const express = require("express");
const app = require("./app.js");

PORT = process.env.PORT || 7000;

const server = app.listen(PORT, () => {
  console.log(`server started at localhost:${PORT}`);
});
