var express = require("express");
var router = express.Router();
var orderController = require("../controller/orderController");

router.route("/").get(orderController.getOrder);
router.route("/history").get(orderController.getAllOrders);
router.route("/create").post(orderController.createOrder);

module.exports = router;
