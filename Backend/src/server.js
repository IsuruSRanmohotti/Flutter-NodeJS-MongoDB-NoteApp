const express = require('express');
const app = express();
const mongoose = require('mongoose');
const bodyParcer = require('body-parser');
const Note = require('./models/note');
app.use(bodyParcer.urlencoded({extended : false}));
app.use(bodyParcer.json());

//Add Your mongoDbPath
const mongoDbPath = "AddYourMongoDb";
mongoose.connect(mongoDbPath).then(function(){
//Home Route
app.get("/", function(req,res){
    const response = {statuscode : res.statusCode ,message:"API is working well"}
    res.json(response);
});

const noteRouter = require('./routes/note');
app.use("/notes", noteRouter);

});

const PORT = process.env.PORT || 5000;
app.listen(PORT,function(){
    console.log("Server Started at port: " + PORT)
});
