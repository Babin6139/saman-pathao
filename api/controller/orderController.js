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
      message: "Your Order has been created",
    });
  } catch (err) {
    next(err);
  }
};

exports.getAllOrders = async (req, res, next) => {
  try {
    const user = await Client.findOne({
      userName: req.query.userName,
    }).populate({
      path: "orders",
      select:
        "orderNo orderStatus startPoint destination bidConfirmed bids.transporter",
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

exports.updateOrder = async (req, res, next) => {
  try {
    const user = await Client.findOne({
      userName: req.body.userName,
    });
    console.log(user);
    if (user.orders.includes(req.body.id)) {
      const order = await Order.findOneAndUpdate(
        {
          _id: req.body.id,
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
        req.body,
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

exports.updatebidDetails = async (req, res, next) => {
  try {
    const update = {
      bidConfirmed: req.body.bidConfirmed,
      transporter: req.body.transporter,
      bidCost: req.body.bidCost,
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

exports.liveUpdate = async (req, res, next) => {
  try {
    const update = {
      timeLocation: req.body.timeLocation,
    };
    const order = await Order.findOneAndUpdate(
      {
        _id: req.body.id,
        orderStatus: "onDelivery",
        transporter: req.body.transporterId,
      },
      update,
      { new: true }
    );
    res.send({ message: "live location updated", order });
  } catch (err) {
    next(err);
  }
};

exports.deleteOrder = async (req, res, next) => {
  try {
    const user = await Client.findOne({
      userName: req.body.userName,
    });
    if (user.orders.includes(req.body.id)) {
      const order = await Order.findOneAndUpdate(
        {
          _id: req.body.id,
          orderStatus: "prebid" || "postbid" || "onbid",
          bidConfirmed: false,
        },
        { orderStatus: "cancelled" },
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

exports.deliveryStatus = async (req, res, next) => {
  try {
    const user = await Client.findOne({
      userName: req.body.userName,
    });
    if (user.orders.includes(req.body.id)) {
      const order = await Order.findOneAndUpdate(
        {
          _id: req.body.id,
          orderStatus: "finalized",
          bidConfirmed: false,
        },
        { orderStatus: req.body.orderStatus },
        { new: true }
      );
      res.send({
        message: `Order status changed to ${req.body.orderStatus}`,
        order,
      });
    } else {
      res.send({ message: "Order not found" });
    }
  } catch (error) {
    next(error);
  }
};
