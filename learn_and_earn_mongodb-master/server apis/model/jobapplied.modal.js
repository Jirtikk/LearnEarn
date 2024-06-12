const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const jobappliedSchema = new Schema({
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
    appliedby:{
        type:String,
    },
    status:{
        type:String,
    },
    date:{
        type:String,
    },
    time:{
        type:String,
    },
    resume:{
        type:String,
    },
});

const jobappliedModel = db.model('jobapplied',jobappliedSchema);
module.exports = jobappliedModel;
