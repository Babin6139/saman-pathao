const bcrypt = require("bcrypt");

const Client = require("../models/client");

exports.addClient = async (req, res, next) => {
  console.log("hello from addClient 1");
  console.log(req.body);
  const hash = await bcrypt.hash(req.body.password, 10);
  req.body.password = hash;
  const userObj = req.body;
  try {
    await Client.create(userObj);
    res.send({ message: "SignUp sucessfull" });
  } catch (err) {
    next(err);
  }
};

exports.login = async (req, res, next) => {
  //   console.log("hello from login");
  try {
    const user = await Client.findOne(
      {
        $or: [{ userName: req.body.userName }, { email: req.body.email }],
      },
      "userName email photo inAppCurrency password rating verified"
    ).populate({
      path: "orders",
      select:
        "orderNo biddingTime shipmentPhoto maxBudget orderStatus bids.bidAmount timeFrame startPoint destination timeLocation distance shipments shipmentWeight",
      match: {
        $or: [
          { orderStatus: "postbid" },
          { orderStatus: "onDelivery" },
          { orderStatus: "onbid" },
        ],
      },
    });

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
          onBidOrders: user.orders
            .map((order, index) => {
              if (order.orderStatus === "onbid") {
                return {
                  orderNo: order.orderNo,
                  status: order.orderStatus,
                  biddingStartTime: order.biddingTime.start,
                  biddingEndTime: order.biddingTime.end,
                  biddingRemainingTime: order.biddingTime.end - Date.now(),
                  photo: order.shipmentPhoto,
                  maxBudget: order.maxBudget,
                  lowestbids: Math.min(...order.bids.bidAmount),
                  distance: order.distance,
                  shipments: order.shipments,
                  shipmentWeight: order.shipmentWeight,
                };
              }
            })
            .filter((el) => el != null),
          onDeliveryOrders: user.orders
            .map((order, index) => {
              if (order.orderStatus === "onDelivery") {
                return {
                  orderNo: order.orderNo,
                  status: order.orderStatus,
                  orderStartTime: order.timeFrame.start,
                  orderEndTime: order.timeFrame.end,
                  expectedRemainingTime: order.timeFrame.end - Date.now(),
                  photo: order.shipmentPhoto,
                  cost: order.bidCost,
                  liveLocation: order.timeLocation.pop(),
                  distance: order.distance,
                  shipments: order.shipments,
                  shipmentWeight: order.shipmentWeight,
                };
              }
            })
            .filter((el) => el != null),
          postBidOrders: user.orders
            .map((order, index) => {
              if (order.orderStatus === "postbid") {
                return {
                  orderNo: order.orderNo,
                  status: order.orderStatus,
                  photo: order.shipmentPhoto,
                  maxBudget: order.maxBudget,
                  orderStartTime: order.timeFrame.start,
                  orderEndTime: order.timeFrame.end,
                  lowestbids: Math.min(...order.bids.bidAmount),
                  distance: order.distance,
                  shipments: order.shipments,
                  shipmentWeight: order.shipmentWeight,
                };
              }
            })
            .filter((el) => el != null),
        };

        res.send({ message: "Login sucessfull", data });
      }
    }
  } catch (err) {
    next(err);
  }
};

exports.updateClient = async (req, res, next) => {
  var update = req.body;
  try {
    if (update.newPassword) {
      const user = await Client.findOne(
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
          await Client.findOneAndUpdate(
            {
              $or: [{ email: req.body.email }, { userName: req.body.userName }],
            },
            update
          );
          res.send({ message: "Password updated" });
        }
      }
    } else {
      const user = await Client.findOneAndUpdate(
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

exports.deleteClient = async (req, res, next) => {
  try {
    const user = await Client.findOneAndDelete({
      $or: [{ userName: req.query.userName }, { email: req.query.email }],
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
    const userDetails = await Client.findOne(
      { userName: req.query.userName },
      "firstName middleName lastName email contactNo address userName verified rating securityDeposit dateCreated ratedBy successfullDeliveries review"
    );
    if (!userDetails) {
      res.send({ message: "User not found" });
    } else {
      res.status(200).send({ userDetails });
    }
  } catch (err) {
    next(err);
  }
};
