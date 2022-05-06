const app = require("./app.js");
const database = require("./mongodb.js");
PORT = process.env.PORT || 7000;
var cron = require("cron").CronJob;
const statusChanger = require("./controller/orderController.js");
const Order = require("./models/order.js");
let onlineUser = [];
app.listen(PORT, () => {
  console.log(`server started at localhost:${PORT}`);
});

//sends onbids order periodically
var autoUpdater = async (req, res) => {
  const headers = {
    "Content-Type": "text/event-stream",
    Connection: "keep-alive",
    "Cache-Control": "no-cache",
  };
  res.writeHead(200, headers);

  const data = await Order.find(
    {
      orderStatus: "onbid",
      // rating: { $lte: rating },
    },
    "orderNo  userName"
  );

  res.write("data: " + `${JSON.stringify(data)} \n\n`);

  const newClient = {
    userName: req.query.userName,
    res,
  };
  onlineUser.push(newClient);

  req.on("close", () => {
    console.log(`${newClient.userName} Connection closed`);
    onlineUser = onlineUser.filter(
      (user) => user.userName !== req.query.userName
    );
  });
};

app.get("/autoUpdate", autoUpdater);

var job = new cron(" */1 * * * *", () => {
  console.log("running a task every  1 minute" + new Date());
  statusChanger.statusChanger("prebid");
  statusChanger.statusChanger("onbid");
  async () => {
    const data = await Order.find(
      {
        orderStatus: "onbid",
        // rating: { $lte: rating },
      },
      "orderNo  userName"
    );
    console.log(onlineUser);
    onlineUser.forEach((user) => {
      user.res.write("data: " + `${JSON.stringify(data)} \n\n`);
    });
  };
});

job.start();
