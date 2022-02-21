const bcrypt = require("bcrypt");

const Transporter = require("../models/transporter");
const Order = require("../models/order");

exports.addTransporter = async (req, res, next) => {
  console.log("hello from addtransporter 1");
  console.log(req.body);
  const hash = await bcrypt.hash(req.body.password, 10);
  req.body.password = hash;
  const userObj = req.body;
  try {
    await Transporter.create(userObj);
    res.send({ message: "SignUp sucessfull" });
  } catch (err) {
    next(err);
  }
};

exports.login = async (req, res, next) => {
  //   console.log("hello from login");
  try {
    const user = await Transporter.findOne({
      $or: [{ userName: req.body.userName }, { email: req.body.email }],
    })
      .populate({
        path: "biddedOrders",
        select:
          "orderNo biddingTime photo maxBudget orderStatus bids.bidAmount timeFrame startPoint destination fragile ",
        match: {
          $or: [{ orderStatus: "postbid" }, { orderStatus: "onbid" }],
        },
      })
      .populate({
        path: "pickUpOrders",
        select:
          "orderNo photo orderStatus bidCost timeFrame startPoint destination fragile",
        match: {
          orderStatus: "finialized",
        },
      });
    const deliveryOrders = await Order.find(
      {
        transporter: user._id,
        orderStatus: "onDelivery",
      },
      "orderNo photo orderStatus bidCost timeFrame startPoint destination "
    );
    const availabelOrders = await Order.find(
      {
        orderStatus: "onbid",
      },
      "orderNo photo orderStatus bidCost timeFrame startPoint destination "
    );
    // console.log(user);
    if (!user) {
      res.send({ message: "Email not found" });
    } else {
      const isMatch = await bcrypt.compare(req.body.password, user.password);
      if (!isMatch) {
        res.send({ message: "Password not match" });
      } else {
        let data = {
          userName: user.userName,
          email: user.email,
          photo: user.photo,
          inAppCurrency: user.inAppCurrency,
          rating: user.rating,
          verified: user.verified,
          transporterId: user._id,
          pickUpOrders: user.pickUpOrders,
          biddedOrders: user.biddedOrders,
          onBidOrders: availabelOrders,
          onDeliveryOrders: deliveryOrders,
        };
        res.send({ message: "Login sucessfull", data });
      }
    }
  } catch (err) {
    next(err);
  }
};

exports.updateTransporter = async (req, res, next) => {
  var update = req.body;
  try {
    if (update.newPassword) {
      const user = await Transporter.findOne(
        { $or: [{ email: req.body.email }, { userName: req.body.userName }] },
        "password"
      );
      if (!user) {
        res.send({ message: "User not found" });
      } else {
        const isMatch = await bcrypt.compare(
          req.body.oldPassword,
          user.password
        );
        if (!isMatch) {
          res.send({ message: "old Password did not match" });
        } else {
          update.password = await bcrypt.hash(update.newPassword, 10);
          await Transporter.findOneAndUpdate(
            {
              $or: [{ email: req.body.email }, { userName: req.body.userName }],
            },
            update
          );
          res.send({ message: "Password updated" });
        }
      }
    } else {
      const user = await Transporter.findOneAndUpdate(
        { $or: [{ email: req.body.email }, { userName: req.body.userName }] },
        update
      );
      if (!user) {
        res.send({ message: "User not found" });
      } else {
        res.send({ message: "User updated" });
      }
    }
  } catch (err) {
    next(err);
  }
};

exports.deleteTransporter = async (req, res, next) => {
  try {
    const user = await Transporter.findOneAndDelete({
      $or: [{ email: req.query.email }, { userName: req.query.userName }],
    });
    if (!user) {
      res.send({ message: "User not found" });
    } else {
      res.send({ message: "User deleted" });
    }
  } catch (err) {
    next(err);
  }
};
