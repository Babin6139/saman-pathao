const Order = require("../models/order");
const transporter = require("../models/transporter");
const mongoose = require("mongoose");

exports.addBids = async (req, res, next) => {
  try {
    const checker = await Order.aggregate([
      {
        $match: {
          orderNo: req.body.orderNo,
        },
      },
      {
        $project: {
          "bids.transporter": 1,
          data: {
            $setIsSubset: [
              [mongoose.Types.ObjectId(req.body.transporterId)],
              "$bids.transporter",
            ],
          },
        },
      },
    ]);
    console.log(checker[0].bids);
    if (!checker[0].data) {
      const order = await Order.findOneAndUpdate(
        { orderNo: req.body.orderNo },
        {
          $push: {
            "bids.transporter": req.body.transporterId,
            "bids.bidAmount": req.body.bidAmount,
          },
        },
        { new: true }
      );
      await transporter.findOneAndUpdate(
        { email: req.body.email },
        { $push: { biddedOders: order._id.toString() } }
      );
      console.log(order);
      res.send({ message: "bid added sucessfully" });
    } else {
      res.send({ message: "you have already bidded for this order" });
    }
  } catch (err) {
    next(err);
  }
};

exports.getAllBids = async (req, res, next) => {
  try {
    const order = await Order.findOne(
      { orderNo: req.query.orderNo },
      "bids.bidAmount"
    )
      .populate("bids.transporter", {
        firstName: 1,
        lastName: 1,
        _id: 0,
        email: 1,
        middleName: 1,
        photo: 1,
        rating: 1,
        ratedBy: 1,
      })
      .sort({ "bids.bidAmount": -1 });
    res.send(order);
  } catch (err) {
    next(err);
  }
};

exports.getBid = async (req, res, next) => {
  try {
    const transporter = await transporter.findOne(
      { email: req.query.email },
      "firstName middleName lastName email rating ratedBy sucessfulDeliveries dateRegistered review photo vechilePhoto vechileNo"
    );
  } catch (error) {
    next(error);
  }
};
