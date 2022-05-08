const { stringify } = require("jade/lib/utils");
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
  requestForVerification: {
    type: String,
    default: "false",
  },
  verified: {
    type: Boolean,
    default: false,
  },
  idCard: {
    type: String,
  },
  licensePhoto: {
    type: String,
  },
  licenseNo: {
    type: String,
  },
  photo: {
    type: String,
    required: true,
  },
  vehiclePhoto: {
    type: String,
  },
  vehicleNo: {
    type: String,
  },
  blueBookPhoto: {
    type: String,
  },
  rating: {
    default: -1,
    type: Number,
  },
  ratedBy: {
    default: 0,
    type: Number,
  },
  review: {
    type: [
      {
        reviewDetail: String,
        reviewedBy: String,
      },
    ],
  },
  inAppCurrency: {
    type: Number,
    default: 0,
  },
  vehicleDimension: {
    type: Array,
  },
  vehicleCapacity: {
    type: Number,
  },
  availableSpace: {
    type: Array,
    // default: vechileDimension,
  },
  availableWeight: {
    type: Number,
    // default: vechileCapacity,
  },
  dateCreated: {
    type: String,
  },
  dateRegistered: {
    type: String,
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
