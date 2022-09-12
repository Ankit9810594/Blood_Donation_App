const jwt = require("jsonwebtoken");
const User = require('../models/auth/user');
exports.protect = (async(req, res, next) => {
    let token;
    if (req.headers.authorization && req.headers.authorization.startsWith("Bearer")) {
        token = req.headers.authorization.split(" ")[1];
    }
    if (!token) {
        res.status(401).json({
            success: false,
            error: "Not authorize to access this route"
        })
    }
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        console.log(decoded);
        req.user = await User.findById(decoded.id);
        next();
    } catch (err) {
        res.status(401).json({
            success: false,
            error: "Not authorize to access this route"
        })

    }
});