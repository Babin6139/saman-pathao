const bcrypt = require("bcrypt");

const Transporter = require("../models/transporter");
const Order = require("../models/order");
const OnlineUser = require("../models/onlineUser");

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
          "orderNo biddingTime shipmentPhoto maxBudget orderStatus bids.bidAmount timeFrame startPoint destination fragile distance shipments shipmentWeight userName",
        match: {
          $or: [{ orderStatus: "postbid" }, { orderStatus: "onbid" }],
        },
      })
      .populate({
        path: "pickUpOrders",
        select:
          "orderNo shipmentPhoto orderStatus bidCost timeFrame startPoint destination fragile distance shipments shipmentWeight userName",
        match: {
          orderStatus: "finialized",
        },
      });
    if (!user) {
      res.send({ message: "user Not found" });
      return 0;
    }
    const deliveryOrders = await Order.find(
      {
        transporter: user._id,
        orderStatus: "onDelivery",
      },
      "orderNo shipmentPhoto orderStatus bidCost timeFrame startPoint destination distance shipments shipmentWeight pickedUpTime userName"
    );
    const availabelOrders = await Order.find(
      {
        orderStatus: "onbid",
        rating: { $lte: user.rating },
      },
      "orderNo shipmentPhoto orderStatus bids.bidAmount timeFrame startPoint destination fragile distance shipments shipmentWeight biddingTime userName"
    );
    // console.log(user);
    if (!user) {
      res.send({ message: "Email not found" });
    } else {
      const isMatch = await bcrypt.compare(req.body.password, user.password);
      if (!isMatch) {
        res.send({ message: "Password not match" });
      } else {
        OnlineUser.findByIdAndUpdate(
          {},
          {
            userName: user.userName,
            loginTime: Date(),
          },
          {
            upsert: true,
          }
        );
        let data = {
          userName: user.userName,
          email: user.email,
          photo: user.photo,
          inAppCurrency: user.inAppCurrency,
          rating: user.rating,
          verified: user.verified,
          transporterId: user._id,
          pickUpOrders: user.pickUpOrders,
          biddedOrders: [],
          onBidOrders: availabelOrders.filter(
            ({ orderNo: val1 }) =>
              !user.biddedOrders.some(({ orderNo: val2 }) => val1 === val2)
          ),
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

exports.userDetails = async (req, res, next) => {
  try {
    const userDetails = await Transporter.findOne(
      { userName: req.query.userName },
      "firstName middleName lastName email contactNo address userName verified rating securityDeposit dateCreated ratedBy successfullDeliveries"
    );
    const vechileDetails = await Transporter.findOne(
      { userName: "shreali" },
      "idCard license licenseNo vechileNo vechilePhoto bluebook vechileDimension vechileCapacity dateRegistered "
    );
    if (!userDetails) {
      res.send({ message: "User not found" });
    } else {
      res.status(200).send({ userDetails, vechileDetails });
    }
  } catch (err) {
    next(err);
  }
};
