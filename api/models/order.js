const mongoose = require("mongoose");
const orderSchema = new mongoose.Schema({
  orderNo: {
    type: String,
    required: true,
  },
  orderStatus: {
    default: "prebid",
    type: String, //prebid onbid postbid finalized onDelivery completed cancelled
  },
  timeFrame: {
    start: { type: Date, required: true },
    end: { type: Date, required: true },
  },
  startPoint: {
    type: [String, Number, Number],
    required: true,
  },
  destination: {
    type: [String, Number, Number],
    required: true,
  },
  distance: {
    type: Number,
    required: true,
  },
  biddingTime: {
    start: { type: Date, required: true },
    end: { type: Date, required: true },
  },
  maxBudget: {
    type: Number,
    required: true,
  },
  shipments: {
    type: Array,
    required: true,
  },
  shipmentPhoto: {
    type: String,
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

  //data added after order is available in database

  bids: {
    transporter: {
      type: [mongoose.ObjectId],
      ref: "transporter",
    },
    bidAmount: {
      type: [Number],
    },
  },
  bidConfirmed: {
    type: Boolean,
    default: false,
  },
  transporter: {
    type: mongoose.ObjectId,
    ref: "transporter",
  },
  bidCost: {
    type: Number,
  },
  timeLocation: {
    type: [[Number, Number, Date]],
  },
});

const order = mongoose.model("order", orderSchema);

module.exports = order;
