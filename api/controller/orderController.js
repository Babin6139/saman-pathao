const Order = require('../models/order');

exports.createOrder = async (req, res, next) => {
    try {
        const order = await Order.create(req.body);
        res.send({ message: "Your Order has been created and added to the bid list" });
    } catch (err) {
        next(err);
    }
}

exports.getOrder = async (req, res, next) => {
    try {
        const order = await Order.findOne({ orderNo: req.query.orderNo });
        res.send(order);
    } catch (err) {
        next(err);
    }
}

exports.getAllOrders = async (req, res, next) => {
    try {
        const orders = await Order.find({});
        res.send(orders);
    } catch (err) {
        next(err);
    }
}

exports.getAllBids = async (req, res, next) => {

}



