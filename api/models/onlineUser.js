const mongoose = require("mongoose");

const onlineUserSchema = new mongoose.Schema({
  userName: {
    required: true,
    type: String,
    unique: true,
  },
  loginTime: {
    type: Date,
    default: Date.now(),
  },
  res: {},
});

const onlineUser = mongoose.model("onlineUser", onlineUserSchema);

module.exports = onlineUser;
