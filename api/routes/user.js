var express = require("express");
var router = express.Router();
var clientController = require("../controller/clientController");
var transporterController = require("../controller/transporterController");
var deliveryController = require("../controller/deliveryController");

router.route("/client/signup").post(clientController.addClient);

router
  .route("/client")
  .post(clientController.login)
  .patch(clientController.updateClient)
  .delete(clientController.deleteClient);

router.route("/client/details").get(clientController.userDetails);

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

module.exports = router;
