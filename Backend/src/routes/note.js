const express =require('express');
const router = express.Router();
const Note = require('./../models/note')
const User = require('./../models/user');

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//All Notes
router.post("/list" ,async function(req,res){
    var notes = await Note.find({userID: req.body.userID});
    res.json(notes);
});

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Notes From Admin Users
router.get("/adminNotes" ,async function(req,res){
    // Query for finding admin users
const adminUsers = await User.find({ admin: true });

// Extract user IDs from admin users
const adminUserIds = adminUsers.map(user => user.userID);

// Query for finding notes of admin users
const adminNotes = await Note.find({ userID: { $in: adminUserIds } });

// Return admin notes
res.json(adminNotes);
});


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Notes From Admin Users with Contains Query Text

router.post("/adminNotes", async function(req, res) {
    const queryText = req.body.queryText; // Update to use req.body instead of req.params

    // Query for finding admin users
    const adminUsers = await User.find({ admin: true });

    // Extract user IDs from admin users
    const adminUserIds = adminUsers.map(user => user.userID);

    // Query for finding notes of admin users that contain the query text in title or content
    const adminNotes = await Note.find({ 
        userID: { $in: adminUserIds },
        $or: [
            { title: { $regex: queryText, $options: 'i' } }, // Case-insensitive title match
            { content: { $regex: queryText, $options: 'i' } } // Case-insensitive content match
        ]
    });

    // Send the response with the adminNotes
    res.json(adminNotes);
});


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Add new Note
router.post("/add" , async function(req,res){

    await Note.deleteOne({id: req.body.id});
    
    const newNote = new Note({
        id:req.body.id,
        userID: req.body.userID,
        title: req.body.title,
        content: req.body.content,
    });
    await newNote.save();
    const response = { message: `New note created. id: ${req.body.id}` };
    res.json(response);
});

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Delete Note
router.post("/delete" , async function(req,res){
    await Note.deleteOne({id: req.body.id});

    const response = { message: `Note Deleted. id ${req.body.id}` };
    res.json(response);
});

module.exports = router;