const express = require('express');
const router = express.Router();
const Note = require('./../model/notes');


//fetch all the notes belonging to a particular user
router.post("/lists",async function(req, res){
    var notes = await Note.find({userid: req.body.userid});
    res.json(notes);
});

//add or update a note
router.post("/add",async function(req, res){ 
    await Note.deleteOne({id:req.body.id});
    var newNotes = new Note({
        id:req.body.id,
        userid: req.body.userid,
        title: req.body.title,
        content: req.body.content
    });
    await newNotes.save();
    const response = {message:"new note created "+ `id: ${req.body.id}`};
    res.json(response);
});

//delete a note
router.post("/delete" , async function(req, res){
    await Note.deleteOne({id: req.body.id});
    const response = {message:"Notes deleted " +`id:${req.body.id}`};
    res.json(response);
});
module.exports =router;
