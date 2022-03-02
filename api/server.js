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
    "orderNo shipmentPhoto orderStatus bids.bidAmount timeFrame startPoint destination fragile distance shipments shipmentWeight biddingTime userName"
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

var job = new cron(" */5 * * * *", () => {
  console.log("running a task every  5 minute" + new Date());
  statusChanger.statusChanger("prebid").then(async () => {
    const data = await Order.find(
      {
        orderStatus: "onbid",
        // rating: { $lte: rating },
      },
      "orderNo shipmentPhoto orderStatus bids.bidAmount timeFrame startPoint destination fragile distance shipments shipmentWeight biddingTime userName"
    );
    onlineUser.forEach((user) => {
      user.res.write("data: " + `${JSON.stringify(data)} \n\n`);
    });
  });
  // statusChanger.statusChanger("onbid").then(console.log);
});

job.start();
