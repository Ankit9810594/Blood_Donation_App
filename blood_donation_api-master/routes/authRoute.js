const express = require("express");
const { register, login, updateProfile } = require("../controller/authController/authController");
const { protect } = require("../middleware/protect");
const router = express.Router();
router.post("/register", register);
router.post("/login", login);
router.put("/update", protect, updateProfile);
module.exports = router;