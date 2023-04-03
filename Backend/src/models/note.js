//Steps
//01. Define Schema => Note : id , userID , title ,content ,dateadded
//02. create model => <model name> <schema> Note

const mongoose = require('mongoose');

const noteSchema = mongoose.Schema({
    id:{
        type: String,
        unique : true,
        required:true,
    },
    userID:{
        type:String,
        required:true,
    },
    content:{
        type:String,
    },
    dateAdded:{
        type:Date,
        default:Date.now,
    },
    title:{
        type:String,
        required:true
    }
});


module.exports = mongoose.model("Note",noteSchema);
