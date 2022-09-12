const { connect } = require("mongoose");
const connectDB = async() => {
    const conn = await connect(process.env.LOCALHOST_URI, {
        useNewUrlParser: true,
        useUnifiedTopology: true

    });
    console.log(`MongoDB Connected: ${conn.connection.host}`);
}
module.exports = connectDB;