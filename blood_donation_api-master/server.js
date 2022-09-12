const express = require("express");
const app = express();
const dotenv = require("dotenv");
const PORT = process.env.PORT || 3000;
const userRoute = require("./routes/authRoute");
const donorRoute = require("./routes/bloodDonorRoute");
dotenv.config({ path: "./config/.env" });
app.use(express.json());
app.use(express.urlencoded({ extended: false }))
const mongodbStatus = require("./config/mongodb");
app.listen(PORT, () => {
    console.log(`Server running in ${PORT} port`)
});
mongodbStatus();

app.use("/api/v1/user", userRoute);
app.use("/api/v1/donor", donorRoute);
app.use("/uploads", express.static(__dirname + "/uploads"));