const Client = require("../models/client");
const Transporter = require("../models/transporter");

exports.ratingAndReview = async (req, res, next) => {
  try {
    const user =
      req.query.userType == "transporter"
        ? await Client.findOne({
            userName: req.body.userNameReviewed,
          })
        : await Transporter.findOne({
            userName: req.body.userNameReviewed,
          });
    if (!user) {
      res.send({ message: "User not found" });
    } else {
      user.rating =
        user.rating === -1
          ? req.body.rating
          : (user.rating + req.body.rating) / 2;
      user.review = [
        ...user.review,
        {
          reviewDetail: req.body.review,
          reviewedBy: req.body.userNameReviewer,
        },
      ];
      user.ratedBy = user.ratedBy + 1;
      await user.save();
      res.send({ message: "User updated" });
    }
  } catch (err) {
    next(err);
  }
};

exports.getReviews = async (req, res, next) => {
  const user =
    req.query.userType == "client"
      ? await Client.findOne(
          {
            userName: req.query.userName,
          },
          "review ratedBy rating -_id"
        )
      : await Transporter.findOne(
          {
            userName: req.query.userName,
          },
          "review ratedBy rating -_id"
        );
  res.send(user);
};

exports.addInAppCurrency = async (req, res, next) => {
  try {
    const user =
      req.query.userType === "client"
        ? await Client.findOne({
            userName: req.body.userName,
          })
        : await Transporter.findOne({
            userName: req.body.userName,
          });
    if (!user) {
      res.send({ message: "User not found" });
    } else {
      user.inAppCurrency = user.inAppCurrency + req.body.inAppCurrency;
      await user.save();
      res.send({ message: "User updated" });
    }
  } catch (err) {
    next(err);
  }
};
