const mongoose = require("mongoose");
const orderSchema = new mongoose.Schema({
  orderNo: {
    type: String,
    required: True,
  },
  timeFrame: {
    type: Array,
    required: True,
  },
  transporter: {
    type: Schema.Types.ObjectId,
    ref: "transporter",
  },
  startPoint: {
    type: String,
    required: True,
  },
  destination: {
    type: String,
    required: True,
  },
  biddingTime: {
    type: Array,
    required: True,
  },
  maxBudget: {
    type: Number,
    required: True,
  },
  distance: {
    type: Number,
    required: True,
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
    required: True,
  },
  shipmentWeight: {
    type: String,
  },
  shipmentDimension: {
    type: Array,
    required: True,
  },
  fragile: {
    type: Boolean,
    required: True,
  },
  minRated: {
    type: String,
  },
});

const order = mongoose.model("order", orderSchema);

module.exports = order;
