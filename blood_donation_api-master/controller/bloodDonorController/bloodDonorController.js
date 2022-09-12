const bloodDonor = require("../../models/bloodDonor/bloodDonor");
exports.donateBlood = (async(req, res) => {

    req.body.user = req.user.id;
    console.log(req.body);
    req.body.image = req.file.path;
    try {

        const donors = await bloodDonor.create(req.body);
        res.status(201).json({
            success: true,
            donors: donors
        })

    } catch (error) {
        console.log(req.use.id);
        res.status(500).json({
            success: false,
            error: error
        })

    }

})
exports.bloodDonorDetails = (async(req, res) => {
    try {
        const donors = await bloodDonor.find();
        res.status(200).json({
            success: true,
            donors: donors
        })

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
})
exports.updateDetails = (async(req, res) => {
    try {
        let donors = await bloodDonor.findById(req.params.id);
        if (!donors) {
            res.status(400).json({
                success: false,
                error: "Not Found"
            })
        }
        donors = await bloodDonor.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
        res.status(200).json({
            success: true,
            data: donors,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
})

exports.userPost = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ user: req.user.id });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.APositive = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ bloodGroup: "A+" });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.BPositive = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ bloodGroup: "B+" });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.OPositive = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ bloodGroup: "O+" });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.ABPositive = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ bloodGroup: "AB+" });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.ANegative = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ bloodGroup: "A-" });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.ONegative = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ bloodGroup: "O-" });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.BNegative = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ bloodGroup: "B-" });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.ABNegative = (async(req, res) => {
    try {
        const aPositive = await bloodDonor.find({ bloodGroup: "AB-" });
        if (!aPositive) {
            res.status(200).json({
                success: false,
                error: "Empty"
            })
        }
        res.status(200).json({
            success: true,
            data: aPositive,
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }
});
exports.deleteDonor = (async(req, res) => {
    try {
        const donor = await bloodDonor.findById(req.params.id);
        if (!donor) {
            res.status(400).json({
                success: false,
                error: "Not Found"
            })
        }
        donor.remove();
        res.status(200).json({
            success: true,
            data: {},
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            error: error
        })

    }

})