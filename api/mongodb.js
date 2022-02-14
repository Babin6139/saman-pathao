const mongoose = require("mongoose");

const uri =
  "mongodb+srv://sathao:user123@cluster0.pv8hp.mongodb.net/samanathao?retryWrites=true&w=majority";
mongoose
  .connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log("MongoDB Connected"));

module.exports = mongoose;
