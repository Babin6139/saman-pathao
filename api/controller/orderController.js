const Order = require("../models/order");
const Client = require("../models/client");

exports.createOrder = async (req, res, next) => {
  try {
    const order = await Order.create(req.body);
    console.log(order._id.toString());
    const user = await Client.findOneAndUpdate(
      { $or: [{ email: req.body.email }, { userName: req.body.userName }] },
      { $push: { orders: order._id.toString() } }
    );
    res.send({
      message: "Your Order has been created and added to the bid list",
    });
  } catch (err) {
    next(err);
  }
};

// exports.getOrder = async (req, res, next) => {
//   try {
//     const order = await Order.findOne({ orderNo: req.query.orderNo });
//     res.send(order);
//   } catch (err) {
//     next(err);
//   }
// };

// exports.getAllOrders = async (req, res, next) => {
//     try {
//         const orders = await Order.find({});
//         res.send(orders);
//     } catch (err) {
//         next(err);
//     }
// }

exports.getAllOrders = async (req, res, next) => {
  try {
    // const user = await Client.aggregate([
    //   { match: { userName: req.query.userName } },
    //   {
    //     $lookup: {
    //       from: "orders",
    //       localField: "orders",
    //       foreignField: "orderNo",
    //       as: "orders",
    //     },
    //   },
    // ]);
    const user = await Client.findOne({
      userName: req.query.userName,
    }).populate({
      path: "orders",
      select: "orderNo startPoint destination bidConfirmed bids.transporter",
    });
    const sendData = user.orders.map((order) => {
      let newObj = JSON.parse(JSON.stringify(order));
      newObj.bidLength = order.bids.transporter.length;
      delete newObj.bids;
      return newObj;
    });
    res.send(sendData);
  } catch (error) {
    next(error);
  }
};

exports.getOrder = async (req, res, next) => {
  try {
    const user = await Client.findOne({
      userName: req.query.userName,
    });
    if (user.orders.includes(req.query.id)) {
      const order = await Order.findOne({ _id: req.query.id });
      res.send(order);
    }
  } catch (error) {
    next(error);
  }
};
