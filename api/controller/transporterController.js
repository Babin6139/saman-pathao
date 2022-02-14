const bcrypt = require("bcrypt");
const Transporter = require("../models/transporter");

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
    });
    // console.log(user);
    if (!user) {
      res.send({ message: "Email not found" });
    } else {
      const isMatch = await bcrypt.compare(req.body.password, user.password);
      if (!isMatch) {
        res.send({ message: "Password not match" });
      } else {
        res.send({ message: "Login sucessfull" });
      }
    }
  } catch (err) {
    next(err);
  }
};

exports.updateTransporter = async (req, res, next) => {
  var update = req.body;
  try {
    const user = await Transporter.findOneAndUpdate(
      { $or: [{ email: req.body.email }, { userName: req.body.userName }] },
      update
    );
    if (!user) {
      res.send({ message: "User not found" });
    } else {
      res.send({ message: "User updated" });
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
