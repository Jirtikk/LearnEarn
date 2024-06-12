const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const interviewSchema = new Schema({
    added:{
        type:String,
    },
    date:{
        type:String,
    },
    time:{
        type:String,
    },
    applied:{
        type:String,
    },
    test:{
        type:String,
    },
    result:{
        type:String,
    },
});

const interviewModel = db.model('interview',interviewSchema);
module.exports = interviewModel;
