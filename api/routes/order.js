var express = require("express");
var router = express.Router();
var orderController = require("../controller/orderController");

router
  .route("/")
  .get(orderController.getOrder)
  .post(orderController.createOrder)
  .patch(orderController.updateOrder)
  .delete(orderController.deleteOrder);

router.route("/bidFinalized").patch(orderController.finializeOrder);

router.route("/history").get(orderController.getAllOrders);

router.route("/orderedBy").get(orderController.orderHolder);

module.exports = router;
