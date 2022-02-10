const bcrypt = require("bcrypt");
const User = require("../models/client");

exports.addClient = async (req, res, next) => {
  console.log("hello from addClient 1");
  console.log(req.body);
  const hash = await bcrypt.hash(req.body.password, 10);
  try {
    await User.create({
      firstName: req.body.firstName,
      middleName: req.body.middleName,
      lastName: req.body.lastName,
      email: req.body.email,
      contactNo: req.body.contactNo,
      address: req.body.address,
      idCard: req.body.idCard,
      photo: req.body.photo,
      password: hash,
      rating: req.body.rating,
      inAppCurrrency: req.body.inAppCurrrency,
    });
    res.send({ message: "SignUp sucessfull" });
  } catch (err) {
    next(err);
  }
};

exports.login = async (req, res, next) => {
  //   console.log("hello from login");
  try {
    const user = await User.findOne({
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
