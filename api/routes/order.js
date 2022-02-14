var express = require("express");
var router = express.Router();
var orderController = require("../controller/orderController");


router.route('/')
    .get(orderController.getOrder);
router.route('/history')
    .get(orderController.getAllOrders);
router.route("/createOrder")
    .post(orderController.createOrder);

module.exports = router