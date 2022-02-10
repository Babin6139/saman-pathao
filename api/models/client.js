const mongoose = require("mongoose");
const clientSchema = new mongoose.Schema({
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
  idCard: {
    type: String,
  },
  photo: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  rating: {
    default: -1,
    type: Number,
  },
  inAppCuurency: {
    default: 0,
    type: Number,
  },
  dateCreated: {
    type: String,
  },
});

const client = mongoose.model("client", clientSchema);

clientSchema.pre("save", function (next) {
  var Date = new Date();
  this.userName = this.email.split("@")[0];
  this.dateCreated = `${Date.getFullYear()}-${
    Date.getMonth() + 1
  }-${Date.getDate()}`;
  next();
});

module.exports = client;
