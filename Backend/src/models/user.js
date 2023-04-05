const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    userID:{
        type:String,
        required:true,
    },
    name:{
        type:String,
        required:true
    },
    admin:{
        type:Boolean,
        required:true
    }
});


module.exports = mongoose.model("User",userSchema);
