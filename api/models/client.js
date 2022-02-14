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

clientSchema.pre("validate", async function (next) {
  console.log(`1hello from pre validate ${this.firstName}`);
  var date = new Date();
  if (!this.userName) this.userName = this.email.split("@")[0];
  this.dateCreated = `${date.getFullYear()}-${
    date.getMonth() + 1
  }-${date.getDate()}`;
  next();
});

const client = mongoose.model("client", clientSchema);
module.exports = client;
