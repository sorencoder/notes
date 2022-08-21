const express = require('express');
const app = express();
const mongoose = require('mongoose');
const Note = require('./model/notes')
const bodyParser =require('body-parser');

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

//location of the MongoDB database
const mongodbpath = "mongodb+srv://ishwar:908870pA.@cluster0.c23bnrn.mongodb.net/?retryWrites=true&w=majority";

//connect to the MongoDB database
mongoose.connect(mongodbpath).then(function(){
    app.get("/", function(req, res){
        const response = {statuscode: res.statusCode, message:"API is working correctly"};
        res.send(response);
    });
    
    // Routes
    const noteRouter = require('./routes/notes');
    app.use("/notes",noteRouter);
});

//PORT on which the backend will be running on the hosted server
const PORT = process.env.PORT || 5000;
app.listen(PORT,function(){
    console.log('server started: '+ PORT);
});
