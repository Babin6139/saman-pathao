const Order = require("../models/order");
const Client = require("../models/client");
const { allUsers } = require("./adminController");

//sends specific order based on orderNo
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
    next(error);
  }
};

//sends all orders based on requested orderStatus
exports.getAllOrders = async (req, res, next) => {
  try {
    let selectOrder, populateTransporter;
    if (req.query.orderStatus === "prebid") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime  maxBudget minRated fragile shipmentPhoto";
    } else if (req.query.orderStatus === "onbid") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame biddingTime maxBudget shipmentPhoto bids";
    } else if (req.query.orderStatus === "postbid") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame maxBudget shipmentPhoto bids";
    } else if (req.query.orderStatus === "finalized") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame shipmentPhoto transporter bidCost";
    } else if (req.query.orderStatus === "onDelivery") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance timeFrame shipmentPhoto timeLocation transporter bidCost pickedUpTime";
      populateTransporter = { path: "transporter", select: "userName" };
    } else if (req.query.orderStatus === "completed") {
      selectOrder =
        "orderNo orderStatus startPoint destination distance shipmentPhoto transporter bidCost deliveredTime";
      populateTransporter = { path: "transporter", select: "userName" };
    } else {
      selectOrder =
        "orderNo orderStatus startPoint destination distance shipmentPhoto";
    }
    const user = await Client.findOne({
      userName: req.query.userName,
    }).populate({
      path: "orders",
      populate: populateTransporter,
      select: selectOrder,
      match: { orderStatus: req.query.orderStatus },
    });
    const sendData = user.orders.bids
      ? user.orders.map((order) => {
          let newObj = JSON.parse(JSON.stringify(order));
          newObj.bidLength = order.bids.transporter.length;
          delete newObj.bids;
          return newObj;
        })
      : user.orders;
    res.send(sendData);
  } catch (error) {
    next(error);
  }
};

//creates new order
exports.createOrder = async (req, res, next) => {
  try {
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

//update exsitng order
exports.updateOrder = async (req, res, next) => {
  try {
    let update = { ...req.body };
    delete update.userName;
    delete update.orderNo;
    console.log(req.body.userName);
    console.log(update.userName);
    const user = await Client.exists({
      userName: req.body.userName,
    }).populate({
      path: "orders",
      match: { orderNo: req.body.orderNo },
    });

    if (user.orders.length > 0) {
      const order = await Order.findOneAndUpdate(
        {
          orderNo: req.body.orderNo,
          $or: [
            { orderStatus: "prebid" },
            {
              $and: [
                { orderStatus: "postbid" },
                { "bids.transporter.length": 0 },
              ],
            },
          ],
        },
        update,
        { new: true }
      );
      res.send({ message: "Order updated", order });
    } else {
      res.send({ message: "Order not found" });
    }
  } catch (error) {
    next(error);
  }
};

//cancells prebid, postbid or onbid order
exports.deleteOrder = async (req, res, next) => {
  try {
    const user = await Client.exists({
      userName: req.body.userName,
    }).populate({
      path: "orders",
      match: { orderNo: req.body.orderNo },
    });
    if (user.orders.length > 0) {
      const order = await Order.findOneAndUpdate(
        {
          orderNo: req.body.orderNo,
          orderStatus: "prebid" || "postbid" || "onbid",
          bidConfirmed: false,
        },
        { orderStatus: "cancelled", bids: { transporter: [], bidAmount: [] } },
        { new: true }
      );
      res.send({ message: "Order cancelled", order });
    } else {
      res.send({ message: "Order not found" });
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
          "biddingTime.end": { $gte: new Date() },
          orderStatus: "prebid",
        };
        break;
      case "onbid":
        updateData.newOrderStatus = "postbid";
        selectFilter = {
          "biddingTime.start": { $lte: new Date() },
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
