const express = require("express");
const User = require("../model/auth");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
// const e = require("express");

const authRouter = express.Router();

authRouter.post("/api/signUp", async (req, res) => {
    try {
        const {name, email, password} = req.body;
        const existingUser = await User.findOne({email})
        if(existingUser) {
            return res.status(400).json({msg: "Welcome back, try signing in. I don't have too much space in my database to save your account again and again :|"});
        }
        let user = new User({
            name,
            email,
            password,
        });
        
        user = await user.save();
        res.json({user});
    } catch (err) {
        res.status(500).json({error: err.message})
    }
});

authRouter.post("/api/signIn", async (req, res) => {
    try {
        const {email, password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res.status(500).json({error: "User does not exist"})
        }

        const isMatch = password == user.password;

        const token = jwt.sign({id: user._id}, "passwordKey")
        res.json({token, ...user._doc});

    } catch (e) {
        res.status(500).json({error: e.message})
    }
});

authRouter.post('/isTokenValid', async (req, res) => {
    try {
        const token = req.header('auth-token');
        if(!token) return res.json(false);
        const verified = jwt.verify(token, 'passwordKey');
        
        if(!verified) return res.json(false);
        const user = await User.findById(verified.id);
        
        if(!user) return res.json(false);
        return res.json(true);
    } catch (err) {
        res.status(500).json({error: err.message});
    }
});

authRouter.post("/", auth, async(req, res) => {
    const user = await User.findById(req.user);
   
    res.json({...user._doc, token: req.token });
});

module.exports = authRouter