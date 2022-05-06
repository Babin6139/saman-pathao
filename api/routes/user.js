var express = require("express");
var router = express.Router();
const clientController = require("../controller/clientController");
const transporterController = require("../controller/transporterController");
const deliveryController = require("../controller/deliveryController");
const miscellanousController = require("../controller/miscellaneousController");

router.route("/client/signup").post(clientController.addClient);
router.route("/client/details").get(clientController.userDetails);

router
  .route("/client")
  .post(clientController.login)
  .patch(clientController.updateClient)
  .delete(clientController.deleteClient);

router.route("/transporter/signup").post(transporterController.addTransporter);
router.route("/transporter/details").get(transporterController.userDetails);

router
  .route("/transporter")
  .post(transporterController.login)
  .patch(transporterController.updateTransporter)
  .delete(transporterController.deleteTransporter);

router.route("/transporter/liveupdate").patch(deliveryController.liveUpdate);

router
  .route("/transporter/deliveryStatus")
  .patch(deliveryController.deliveryStatus);

router
  .route("/ratingandreview")
  .get(miscellanousController.getReviews)
  .post(miscellanousController.ratingAndReview);

router.route("/inAppCurrency").post(miscellanousController.addInAppCurrency);

module.exports = router;
