const mongoose = require("mongoose");
const adminSchema = new mongoose.Schema({
    userName: {
        type: String,
        default: "admin",
        required: true,
    },
    password: {
        type: String,
        default: "admin",
        required: true
    }
});

const admin = mongoose.model("admin", adminSchema);
module.exports = admin;