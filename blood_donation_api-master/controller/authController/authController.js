const user = require('../../models/auth/user');
exports.register = (async(req, res) => {

    const { fullName, email, password, bloodGroup, address, gender, phone } = req.body
    try {
        const registerUser = await user.create({
            fullName,
            email,
            password,
            bloodGroup,
            address,
            gender,
            phone
        });
        const token = registerUser.getSignedJwtToken();
        res.status(201).json({
            success: true,
            user: registerUser,
            token: token
        })
    } catch (error) {

        res.status(500).json({
            success: false,
            error: error
        })

    }
})

exports.login = (async(req, res) => {
        const { email, password } = req.body;
        try {
            const loginUser = await user.findOne({ email: email });
            if (!loginUser) {
                res.status(404).json({
                    success: false,
                    error: "Invalid Credentials"
                })
            }
            const isMatch = await loginUser.matchPassword(password);
            if (!isMatch) {
                res.status(404).json({
                    success: false,
                    error: "Invalid Credentials"
                })
            }
            const token = loginUser.getSignedJwtToken();
            res.status(200).json({
                success: true,
                user: loginUser,
                token: token
            })

        } catch (error) {
            res.status(500).json({
                success: false,
                error: error
            })

        }
    }),

    exports.updateProfile = (async(req, res) => {

        try {
            let updateUser = await user.findById(req.user.id);
            console.log(updateUser);

            if (!updateUser) {
                res.status(400).json({
                    success: false,
                    error: "Not Found"
                })
            }
            updateUser = await user.findByIdAndUpdate(req.user.id, req.body, { new: true, runValidators: true });
            res.status(200).json({
                success: true,
                user: updateUser,
            });

        } catch (error) {
            console.log(error);
            res.status(500).json({
                success: false,
                error: error
            })

        }
    })