const mongoose = require("mongoose");

const clientSchema = new mongoose.Schema({
  address: {
    type: String,
    required: true,
  },
  contactNo: {
    type: String,
    required: true,
  },
  dateCreated: {
    type: String,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  firstName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: true,
  },
  middleName: {
    type: String,
  },
  password: {
    type: String,
    required: true,
  },
  photo: {
    type: String,
    required: true,
  },
  userName: {
    type: String,
  },
  //data that will be added after signup
  idCard: {
    type: String,
  },
  verified: {
    type: Boolean,
    default: false,
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
    default: 0,
    type: Number,
  },

  orders: {
    type: [mongoose.ObjectId],
    ref: "order",
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
