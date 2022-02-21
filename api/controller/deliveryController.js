const Order = require("../models/order");

exports.liveUpdate = async (req, res, next) => {
  try {
    const order = await Order.findOneAndUpdate(
      {
        orderNo: req.body.orderNo,
        orderStatus: "onDelivery",
      },
      { $push: { timeLocation: req.body.timeLocation } },
      { new: true }
    );
    res.send({ message: "live location updated", order });
  } catch (err) {
    next(err);
  }
};

exports.deliveryStatus = async (req, res, next) => {
  try {
    let update = {
      orderStatus: req.body.orderStatus,
      verifiedByClient: false,
    };
    if (req.body.orderStatus === "ondelivery") {
      update.pickedUpTime = new Date();
    } else if (req.body.orderStatus === "completed") {
      update.deliveredTime = new Date();
    }
    const order = await Order.findOneAndUpdate(
      {
        orderNo: req.body.orderNo,
        orderStatus: "finalized",
      },
      update,
      { new: true }
    );
    res.send({
      message: `Order status changed to ${req.body.orderStatus}`,
      order,
    });
  } catch (error) {
    next(error);
  }
};
