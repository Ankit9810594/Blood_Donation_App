const express = require("express");
const { bloodDonorDetails, donateBlood, deleteDonor, updateDetails, APositive, OPositive, BPositive, ABPositive, ANegative, ONegative, BNegative, ABNegative, userPost } = require("../controller/bloodDonorController/bloodDonorController");
const { protect } = require("../middleware/protect");
const upload = require("../utils/multer")
const router = express.Router();
router.get('/get', bloodDonorDetails);
router.get("/user/post", protect, userPost)
router.post('/post', protect, upload.single('image'), donateBlood);
router.delete('/delete/:id', deleteDonor),
router.put('/update/:id', updateDetails);
router.get('/aPositive', APositive);
router.get('/oPositive', OPositive);
router.get('/bPositive', BPositive);
router.get('/abPositive', ABPositive);
router.get('/aNegative', ANegative);
router.get('/oNegative', ONegative);
router.get('/bNegative', BNegative);
router.get('/abNegative', ABNegative);


module.exports = router;