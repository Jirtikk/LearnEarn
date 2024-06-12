const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const communitySchema = new Schema({
    text:{
        type:String,
    },
    time:{
        type:String,
    },
    name:{
        type:String,
    },
    imgp:{
        type:String,
    },
    img:{
        type:String,
    },
});

const communityModel = db.model('community',communitySchema);
module.exports = communityModel;
