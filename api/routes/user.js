var express = require("express");
var router = express.Router();
var clientController = require("../controller/clientController");
var transporterController = require("../controller/transporterController");

router.route("/client/signup").post(clientController.addClient);
router
  .route("/client")
  .post(clientController.login)
  .patch(clientController.updateClient)
  .delete(clientController.deleteClient);

router.route("/transporter/signup").post(transporterController.addTransporter);
router
  .route("/transporter")
  .post(transporterController.login)
  .patch(transporterController.updateTransporter)
  .delete(transporterController.deleteTransporter);

module.exports = router;
