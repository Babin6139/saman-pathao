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
  bids: {
    transporter: {
      type: [mongoose.ObjectId],
      ref: "transporter",
    },
    bidAmount: {
      type: Array,
    },
  },
  distance: {
    type: Number,
    required: true,
  },
  bidConfirmed: {
    type: Boolean,
    default: false,
  },
  bidCost: {
    type: Number,
  },
  currentLocation: {
    type: String,
  },
  shipments: {
    type: Array,
    required: true,
  },
  shipmentWeight: {
    type: Number,
  },
  shipmentDimension: {
    length: {
      type: Array,
      required: true,
    },
    width: {
      type: Array,
      required: true,
    },
    height: {
      type: Array,
      required: true,
    },
  },
  fragile: {
    type: Boolean,
    required: true,
  },
  minRated: {
    type: Number,
  },
  orderStatus: {
    type: String, //prebid onbid postbid finalized completed cancelled
  },
});

const order = mongoose.model("order", orderSchema);

module.exports = order;
