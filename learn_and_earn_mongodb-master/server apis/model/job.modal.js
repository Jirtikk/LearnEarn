const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const jobSchema = new Schema({
    addedby:{
        type:String,
    },
    title:{
        type:String,
    },
    des:{
        type:String,
    },
    companyname:{
        type:String,
    },
    salary:{
        type:String,
    },
});

const jobModel = db.model('job',jobSchema);
module.exports = jobModel;
