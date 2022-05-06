const Order = require("./models/order");
const Client = require("./models/client");

async function orderNoGenerator(userName) {
  generatedNo = ` ${userName}-${Math.round(new Date().getTime() / 1000)}`;
  console.log("generatedNo", generatedNo);
  const oldOrderNoChecker = await Order.exists({ orderNo: generatedNo });
  if (oldOrderNoChecker) {
    orderNoGenerator(userName);
  } else {
    return generatedNo;
  }
}

var x = orderNoGenerator("mks").then((data) => {
  return data;
});
console.log(x);
