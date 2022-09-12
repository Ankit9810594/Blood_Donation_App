const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const user = new mongoose.Schema({
    fullName: {
        type: String,
        required: [true, "Full Name is Required"]

    },
    email: {
        type: String,
        required: [true, "Email is required"]
    },

    password: {
        type: String,
        required: [true, "Password is required"]
    },
    bloodGroup: {
        type: String,
        required: [true, "Blood Group is required"]
    },
    address: {
        type: String,
        required: [true, "Address is required"]
    },
    gender: {
        type: String,
        required: [true, "Gender is required"]
    },
    phone: {
        type: String,
        required: [true, "Phone number is required"]
    }
});
user.pre("save", async function(next) {
    if (!this.isModified("password")) {
        next();
    }
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);

})
user.methods.getSignedJwtToken = function() {
    return jwt.sign({ id: this._id }, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRE });
};
// match user entered password to hashed password in databse
user.methods.matchPassword = async function(enteredPassword) {
    return await bcrypt.compare(enteredPassword, this.password);
};
module.exports = mongoose.model("User", user);