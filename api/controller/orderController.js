const Order = require("../models/order");
const Client = require("../models/client");
const admin = require("./adminController");
const { ConnectionPoolClosedEvent } = require("mongodb");

async function orderNoGenerator(userName) {
  generatedNo = ` ${userName}-${Math.round(new Date().getTime() / 1000)}`;
  const oldOrderNoChecker = await Order.exists({ orderNo: generatedNo });
  if (oldOrderNoChecker) {
    orderNoGenerator(userName);
  } else {
    return generatedNo;
  }
}

/**
 * for getting specific order based on orderNo for client
 */

exports.getOrder = async (req, res, next) => {
  try {
    const user = await Client.findOne(
      {
        userName: req.query.userName,
      },
      "-_id rating photo contactNo firstName lastName middleName"
    ).populate({
      path: "orders",
      populate: { path: "bids.transporter", select: "userName rating" },
      match: { orderNo: req.query.orderNo },
    });
    res.send({ user, orders: user.orders });
  } catch (error) {
    res.sendStatus(400);
  }
};

/**
 *sends all orders based on requested orderStatus
 * orderStatus can be prebid, postbid, onbid, cancelled
 */

exports.getAllOrders = async (req, res, next) => {
  try {
    let selectOrder, populateTransporter;
    if (req.query.orderStatus === "prebid") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime maxBudget minRated fragile shipmentPhoto shipments shipmentWeight bids transporter bidCost timeLocation pickedUpTime deliveredTime";
    } else if (req.query.orderStatus === "onbid") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime maxBudget minRated fragile shipmentPhoto shipments shipmentWeight bids transporter bidCost timeLocation pickedUpTime deliveredTime";
    } else if (req.query.orderStatus === "postbid") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime maxBudget minRated fragile shipmentPhoto shipments shipmentWeight bids transporter bidCost timeLocation pickedUpTime deliveredTime";
    } else if (req.query.orderStatus === "finalized") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime maxBudget minRated fragile shipmentPhoto shipments shipmentWeight bids transporter bidCost timeLocation pickedUpTime deliveredTime";
    } else if (req.query.orderStatus === "onDelivery") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime maxBudget minRated fragile shipmentPhoto shipments shipmentWeight bids transporter bidCost timeLocation pickedUpTime deliveredTime";
      populateTransporter = { path: "transporter", select: "userName" };
    } else if (req.query.orderStatus === "completed") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime maxBudget minRated fragile shipmentPhoto shipments shipmentWeight bids transporter bidCost timeLocation pickedUpTime deliveredTime";
      populateTransporter = { path: "transporter", select: "userName" };
    } else {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime maxBudget minRated fragile shipmentPhoto shipments shipmentWeight bids transporter bidCost timeLocation pickedUpTime deliveredTime";
    }
    // console.log(req.query.userType);
    if (req.query.userType === "transporter") {
      const sendData = await Order.find(
        {
          orderStatus: req.query.orderStatus,
          minRated: { $lte: req.query.rating },
        },
        selectOrder
      );

      res.send(sendData);
      return 0;
    }
    const user = await Client.findOne({
      userName: req.query.userName,
    }).populate({
      path: "orders",
      populate: populateTransporter,
      select: selectOrder,
      match: { orderStatus: req.query.orderStatus },
    });

    user.orders.bids
      ? user.orders.map((order) => {
          // console.log("hello");
          let newObj = JSON.parse(JSON.stringify(order));
          newObj.bidLength = order.bids.transporter.length;
          delete newObj.bids;
          return newObj;
        })
      : user.orders;
    const sendData = user.orders;
    res.send(sendData);
  } catch (error) {
    next(error);
  }
};

/**
 * creates new order
 */

exports.createOrder = async (req, res, next) => {
  try {
    var newOrderNo = `${req.body.userName}-${Math.round(
      new Date().getTime() / 1000
    )}`;
    req.body.orderNo = newOrderNo.trim();
    const order = await Order.create(req.body);
    console.log(order._id.toString());
    await Client.findOneAndUpdate(
      { $or: [{ email: req.body.email }, { userName: req.body.userName }] },
      { $push: { orders: order._id.toString() } }
    );
    res.send({
      message: "Your Order has been created",
    });
  } catch (err) {
    next(err);
  }
};

/**
 * update existing order
 */

exports.updateOrder = async (req, res, next) => {
  try {
    let update = { ...req.body };
    delete update.userName;
    delete update.orderNo;
    console.log(req.body.userName);
    console.log(update.userName);
    const user = await Client.exists({
      userName: req.body.userName,
    });
    if (user) {
      const order = await Order.findOneAndUpdate(
        { orderNo: req.body.orderNo },
        update,
        { new: true }
      );
      res.send({ message: "Order updated", order });
    } else {
      res.send({ messsage: "Invalid user" });
    }
  } catch (error) {
    res.send(error);
  }
};

//cancells prebid, postbid or onbid order
exports.deleteOrder = async (req, res, next) => {
  try {
    const user = await Client.exists({
      userName: req.body.userName,
    });
    if (user) {
      newOrderStatus = "cancelled";
      selectFilter = {
        orderNo: req.body.orderNo,
      };
      await Order.updateMany(
        selectFilter,
        {
          orderStatus: newOrderStatus,
        },
        { new: true }
      );
      res.send({ message: "order cancelled" });
    } else {
      res.send({ message: "Order or user not found" });
    }
  } catch (error) {
    next(error);
  }
};

//client selects a suitable bid from transporter
exports.finializeOrder = async (req, res, next) => {
  try {
    const update = {
      bidConfirmed: true,
      transporter: req.body.transporter,
      bidCost: req.body.bidCost,
      bids: {
        transporter: [],
        bidCost: [],
      },
      orderStatus: "finalized",
    };
    const user = await Client.findOne({
      userName: req.body.userName,
    });
    if (user.orders.includes(req.body.id)) {
      const order = await Order.findOneAndUpdate(
        {
          _id: req.body.id,
          orderStatus: "postbid",
        },
        update,
        { new: true }
      );
      res.send({ message: "bid finalized", order });
    } else {
      res.send({ message: "user has no such order" });
    }
  } catch (err) {
    next(err);
  }
};

//changes order status from onbid to postbid and postbid to onbid
exports.statusChanger = async (oldOrderStatus) => {
  try {
    let updateData = {};
    let selectFilter;
    switch (oldOrderStatus) {
      case "prebid":
        updateData.newOrderStatus = "onbid";
        selectFilter = {
          "biddingTime.start": { $lte: new Date() },
          // "biddingTime.end": { $gte: new Date() },
          orderStatus: "prebid",
        };
        break;
      case "onbid":
        updateData.newOrderStatus = "postbid";
        selectFilter = {
          // "biddingTime.start": { $lte: new Date() },
          "biddingTime.end": { $lte: new Date() },
          orderStatus: "onbid",
        };
        break;
    }

    const order = await Order.updateMany(
      selectFilter,
      {
        orderStatus: updateData.newOrderStatus,
      },
      { new: true }
    );
    return order;
  } catch (err) {
    return { err };
  }
};

exports.orderHolder = async (req, res, next) => {
  try {
    const order = await Order.findOne(
      { orderNo: req.query.orderNo },
      "userName -_id"
    );

    const user = await Client.findOne(
      {
        userName: order.userName,
      },
      "-_id rating ratedBy email review photo contactNo firstName lastName middleName"
    );
    res.send({ user });
  } catch (error) {
    res.sendStatus(400);
  }
};
