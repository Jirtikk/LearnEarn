const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const quizSchema = new Schema({
    courseid:{
        type:String,
    },
    duration:{
        type:String,
        require:true
    },
    questionanswer:{
        type:[],
        require:true
    },
    user:[
        {
            type:String,
        }
    ]
});

const QuizModel = db.model('quiz',quizSchema);
module.exports = QuizModel;
