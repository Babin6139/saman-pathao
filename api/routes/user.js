var express = require("express");
var router = express.Router();
var clientController = require("../controller/clientController");

router.route("/client/login").post(clientController.login);

router.route("/client/signup").post(clientController.addClient);

module.exports = router;
