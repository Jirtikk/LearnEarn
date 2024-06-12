const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const courseSchema = new Schema({
    img:{
        type:String,
    },
    des:{
        type:String,
    },
    rating:{
        type:String,
    },
    student:{
        type:String,
    },
    title:{
        type:String,
    },
    ins:{
        type:String,
    },
    type:{
        type:String,
    }
});

const courseModel = db.model('course',courseSchema);
module.exports = courseModel;