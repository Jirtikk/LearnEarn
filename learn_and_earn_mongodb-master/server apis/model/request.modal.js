const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const requestSchema = new Schema({
    uid:{
        type:String,
    },
    iid:{
        type:String,
    },
    status:{
        type:String,
    }
});

const requestModel = db.model('request',requestSchema);
module.exports = requestModel;