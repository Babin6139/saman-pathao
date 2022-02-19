var express = require("express");
var router = express.Router();
var orderController = require("../controller/orderController");

router
  .route("/")
  .get(orderController.getOrder)
  .post(orderController.createOrder)
  .patch(orderController.updateOrder)
  .delete(orderController.deleteOrder);

router.route("/bidFinalized").patch(orderController.updatebidDetails);

router.route("/deliveryStatus").patch(orderController.deliveryStatus);

router.route("/liveUpdate").patch(orderController.liveUpdate);

router.route("/history").get(orderController.getAllOrders);

module.exports = router;
