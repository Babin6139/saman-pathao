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
  verifiefied: {
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
    unique: True,
  },
  userPhoto: {
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
});

transporterSchema.pre("save", function (err, next) {
  try {
    var date = new Date();
    this.userName = this.email.split("@")[0];
    this.dateCreated = `${Date.getFullYear()}-${Date.getMonth() + 1
      }-${Date.getDate()}`;
    next();
  } catch {
    return next(err);
  }
});

const transporter = mongoose.model("transporter", transporterSchema);
module.exports = transporter;
