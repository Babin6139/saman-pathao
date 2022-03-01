const app = require("./app.js");
const database = require("./mongodb.js");
PORT = process.env.PORT || 7000;
var cron = require("cron").CronJob;
const statusChanger = require("./controller/orderController.js");

app.listen(PORT, () => {
  console.log(`server started at localhost:${PORT}`);
});

var job = new cron(" */5 * * * *", () => {
  console.log("running a task every  5 minute");
  statusChanger.statusChanger("prebid").then(console.log);
  // statusChanger.statusChanger("onbid").then(console.log);
});
job.start();
