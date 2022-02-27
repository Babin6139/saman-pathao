const mongoose = require("mongoose");
const transporterSchema = new mongoose.Schema({
  firstName: {
    type: String,
    required: true,
  },
  middleName: {
    type: String,
  },
  lastName: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  contactNo: {
    type: Array,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  userName: {
    type: String,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  verified: {
    type: Boolean,
    default: false,
  },
  idCard: {
    type: String,
  },
  license: {
    type: String,
  },
  licenseNo: {
    type: String,
  },
  photo: {
    type: String,
    required: true,
  },
  vechilePhoto: {
    type: String,
  },
  vechileNo: {
    type: String,
  },
  blueBook: {
    type: String,
  },
  rating: {
    default: -1,
    type: Number,
  },
  securityDeposit: {
    type: Number,
    default: 0,
  },
  vechileDimesion: {
    type: Array,
  },
  vechileCapacity: {
    type: Number,
  },
  availableSpace: {
    type: Array,
  },
  availableWeight: {
    type: Number,
  },
  dateCreated: {
    type: String,
  },
  dateRegistered: {
    type: String,
  },
  ratedBy: {
    type: Number,
  },
  successfullDeliveries: {
    type: Number,
  },
  biddedOrders: {
    type: [mongoose.ObjectId],
    ref: "order",
  },
  pickUpOrders: {
    type: [mongoose.ObjectId],
    ref: "order",
  },
  review: {
    type: [String],
  },
});

transporterSchema.pre("validate", function (next) {
  try {
    var date = new Date();
    if (!this.userName) this.userName = this.email.split("@")[0];
    this.dateCreated = `${date.getFullYear()}-${
      date.getMonth() + 1
    }-${date.getDate()}`;
    next();
  } catch {
    return next(err);
  }
});
const transporter = mongoose.model("transporter", transporterSchema);
module.exports = transporter;
