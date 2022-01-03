const mongoose = require("mongoose");
const orderSchema = new mongoose.Schema({
  orderNo: {
    type: String,
    required: True,
  },
  transporter: {
    type: Array,
  },
  bidAmount: {
    type: Array,
  },
});

const order = mongoose.model("order", orderSchema);

module.exports = order;
