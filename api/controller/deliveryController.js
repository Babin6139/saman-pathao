const Order = require("../models/order");
const Transporter = require("../models/transporter");

exports.liveUpdate = async (req, res, next) => {
  try {
    const transporter = await Transporter.exists({
      userName: req.body.userName,
    });
    req.body.timeLocation.push(Date.now());
    const order = await Order.findOneAndUpdate(
      {
        orderStatus: "onDelivery",
        transporter: transporter._id,
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
