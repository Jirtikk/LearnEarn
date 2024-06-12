const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const adverSchema = new Schema({
    img:{
        type:String,
        require:true
    },
});

const adverModel = db.model('adver',adverSchema);
module.exports = adverModel;
