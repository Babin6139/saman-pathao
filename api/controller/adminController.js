const User = require("../models/client");
const Transporter = require("../models/transporter");
const Admin = require("../models/admin");

exports.adminLogin = async (req, res, next) => {
    try {
        const admin = await Admin.findOne({ userName: req.body.userName, password: req.body.password });
        if (!admin) {
            res.send({ message: "Invalid username or password" });
        } else {
            res.send({ message: "Welcome Admin. Login sucessfull" })
        }
    } catch (err) {
        next(err);
    }
}

exports.allUsers = async (req, res, next) => {
    try {
        const users = await User.find({}, '-password');
        res.send(users);
    } catch (err) {
        next(err);
    }
}

exports.allTransporters = async (req, res, next) => {
    try {
        const transporters = await Transporter.find({}, '-password');
        res.send(transporters);
    } catch (err) {
        next(err);
    }
}

exports.deleteTransporter = async (req, res, next) => {
    try {
        await Transporter.deleteOne({ $or: [{ userName: req.query.userName }, { email: req.query.email }] });
        res.send({ message: `${req.query.email ? req.query.email : req.query.userName} Transporter deleted` });
    } catch (err) {
        next(err);
    }
}

exports.deleteUser = async (req, res, next) => {
    try {
        await User.deleteOne({ $or: [{ userName: req.query.userName }, { email: req.query.email }] });
        res.send({ message: `${req.query.email ? req.query.email : req.query.userName} User deleted` });
    } catch (err) {
        next(err);
    }
}

exports.registerTransporter = async (req, res, next) => {
    try {
        const transporter = await Transporter.findOneAndUpdate({ email: req.body.email },
            {
                verified: true,
            });
        if (transporter) {
            res.send({ message: "Transporter registered successfully" });
        } else {
            res.send({ message: "Transporter not found" });
        }
    } catch (err) {
        next(err);
    }
}

exports.verifyUser = async (req, res, next) => {
    try {
        const user = await User.findOneAndUpdate({ email: req.body.email },
            {
                verified: true,
            });
        if (user) {
            res.send({ message: "User verified successfully" });
        }
        else {
            res.send({ message: "User not found" });
        }
    } catch (err) {
        next(err);
    }
}
