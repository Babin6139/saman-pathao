const mongoose = require("mongoose");
const orderSchema = new mongoose.Schema({
  orderNo: {
    type: String,
    required: true,
  },
  timeFrame: {
    type: Array,
    required: true,
  },
  transporter: {
    type: mongoose.ObjectId,
    ref: "transporter",
  },
  startPoint: {
    type: String,
    required: true,
  },
  destination: {
    type: String,
    required: true,
  },
  biddingTime: {
    type: Array,
    required: true,
  },
  maxBudget: {
    type: Number,
    required: true,
  },
  distance: {
    type: Number,
    required: true,
  },
  bidConfirmed: {
    type: String,
  },
  bidCost: {
    type: String,
  },
  currentLocation: {
    type: String,
  },
  shipments: {
    type: Array,
    required: true,
  },
  shipmentWeight: {
    type: String,
  },
  shipmentDimension: {
    type: Array,
    required: true,
  },
  fragile: {
    type: Boolean,
    required: true,
  },
  minRated: {
    type: String,
  },
});

const order = mongoose.model("order", orderSchema);

module.exports = order;
