const express =require('express');
const router = express.Router();
const User = require('../models/user')


router.get("/list" ,async function(req,res){
    var users = await User.find();
    res.json(users);
});

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Add New User

router.post("/add" , async function(req,res){

    await User.deleteOne({id: req.body.userID});
    
    const newUser = new User({
        userID:req.body.userID,
        name: req.body.name,
        admin: req.body.admin
    });
    await newUser.save();
    const response = { message: `New user created. id: ${req.body.userID}` };
    res.json(response);
});

module.exports = router;