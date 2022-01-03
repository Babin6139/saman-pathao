const { MongoClient } = require("mongodb");
const mongoose = require("mongoose");
const client = require("./models/client");
const uri =
  "mongodb+srv://sathao:user123@cluster0.pv8hp.mongodb.net/samanathao?retryWrites=true&w=majority";

mongoose
  .connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then((data) => {
    client.find({ firstName: "Ankit" }, "-_id", (users, err) => {
      if (err) {
        console.log(err);
      } else {
        console.log(users);
      }
    });
  });
