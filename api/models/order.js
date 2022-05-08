const mongoose = require("mongoose");
const orderSchema = new mongoose.Schema({
  orderNo: {
    type: String,
    unique: true,
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
  userName: {
    // required: true,
    type: String,
  },
  maxBudget: {
    type: Number,
    required: true,
  },
  shipments: {
    type: Array,
    required: true,
  },
  shipmentCount: {
    type: Array,
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
  pickedUpTime: {
    type: Date,
  },
  deliveredTime: {
    type: Date,
  },
  verifiedByClient: {
    type: Boolean,
    default: false,
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
    default: 0,
  },
  timeLocation: {
    type: [[Number, Number, Date]],
  },
});

const order = mongoose.model("order", orderSchema);

module.exports = order;
