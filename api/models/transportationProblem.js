const { ObjectId } = require("mongodb");
const mongoose = require("mongoose");
const transporterProblemSchema = new mongoose.Schema({
  transporterId: {
    type: mongoose.ObjectId,
    ref: "transporter",
  },
  timeTable: [
    {
      time: {
        type: Date,
      },
      availableWeight: {
        type: Number,
      },
      location: {
        type: [string, Number, Number],
      },
      availableVolume: {
        type: [Number, Number, Number],
      },
    },
  ],
});
