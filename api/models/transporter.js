const mongoose = require("mongoose");
const transporterSchema = new mongoose.Schema({
  firstName: {
    type: String,
    required: true,
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
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
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
    type: Number,
  },
  securityDeposit: {
    type: String,
  },
  vechileDimesion: {
    type: String,
  },
  vechileCapacity: {
    type: String,
  },
  availableSpace: {
    type: String,
  },
  availableWeight: {
    type: String,
  },
});

const transporter = mongoose.model("transporter", transporterSchema);

module.exports = transporter;
