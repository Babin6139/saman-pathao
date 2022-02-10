var express = require("express");
var router = express.Router();
var adminController = require("../controller/adminController");

router.route("/login")
    .post(adminController.adminLogin);

router.route("/dashboard/users")
    .get(adminController.allUsers)
    .patch(adminController.verifyUser)
    .delete(adminController.deleteUser);

router.route("/dashboard/transporters")
    .get(adminController.allTransporters)
    .patch(adminController.verifyTransporter)
    .delete(adminController.deleteTransporter);

module.exports = router;