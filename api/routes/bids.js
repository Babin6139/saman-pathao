const express = require("express");
const router = express.Router();

const bidController = require("../controller/bidController");

router.route("/").get(bidController.getAllBids).post(bidController.addBids);

module.exports = router;
