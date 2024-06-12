const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const classSchema = new Schema({
    name:{
        type:String,
    },
    des:{
        type:String,
    },
    date:{
        type:String,
    },
    time:{
        type:String,
    },
    addedby:{
        type:String,
    }
});

const classModel = db.model('class',classSchema);
module.exports = classModel;