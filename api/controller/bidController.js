const Order = require("../models/order");
const Transporter = require("../models/transporter");
const Client = require("../models/client");
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
    const user = await Client.exists({
      $or: [{ userName: req.query.userName }, { email: req.query.email }],
    });
    if (user) {
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
    } else {
      res.send({ message: "you do not have this order" });
    }
  } catch (err) {
    next(err);
  }
};

exports.getBid = async (req, res, next) => {
  try {
    const transporter = await Transporter.findOne(
      { email: req.query.email },
      "firstName middleName lastName email rating ratedBy sucessfulDeliveries dateRegistered review photo vechilePhoto vechileNo "
    );
    res.send(transporter);
  } catch (error) {
    next(error);
  }
};

exports.updateBids = async (req, res, next) => {
  try {
    var i;
    const bids = await Order.findOne({ orderNo: req.body.orderNo }, "bids");
    bids.bids.transporter.forEach((element, index) => {
      if (element.toString() === req.body.transporterId) {
        i = index;
      }
    });
    console.log(i);

    const newBids = await Order.findOneAndUpdate(
      { orderNo: req.body.orderNo },
      { $set: { [`bids.bidAmount.${i}`]: req.body.bidAmount } },
      { new: true }
    );
    console.log(bids.bids.bidAmount[i]);
    res.send(newBids);
  } catch (error) {
    next(error);
  }
};

exports.deleteBids = async (req, res, next) => {
  try {
    var index;
    const session = await Order.startSession();
    await session.withTransaction(async () => {
      const bids = await Order.findOne({ orderNo: req.query.orderNo }, "bids ");
      bids.bids.transporter.filter((element, index) => {
        if (element.toString() === req.query.transporterId) i = index;
        return element.toString() != req.query.transporterId;
      });
      bids.bids.transporter.filter((element, index) => {
        return element.toString() != req.query.transporterId;
      });
      for (var j = 0; j < bids.bids.transporter.length; j++) {
        if (bids.bids.transporter[j].toString() === req.query.transporterId) {
          index = j;
        }
      }
      bids.bids.transporter.splice(index, 1);
      bids.bids.bidAmount.splice(index, 1);
      await Order.findOneAndUpdate(
        { orderNo: req.query.orderNo },
        { $set: { bids: bids.bids } }
      );
      console.log(bids.bids, index);
    });
    session.endSession();
    res.send({ message: "bid deleted sucessfully" });
  } catch (error) {
    next(error);
  }
};

exports.getBidHistory = async (req, res, next) => {
  try {
    const order = await Order.findOne({
      orderNo: req.query.orderNo,
      $in: { orderStatus: ["postbid", "onbid"] },
      "bids.transporter": mongoose.Types.ObjectId(req.query.transporterId),
    });
    res.send(order);
  } catch (err) {
    next(err);
  }
};
