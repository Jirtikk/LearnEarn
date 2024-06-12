const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const startedSchema = new Schema({
    number:{
        type:String,
    },
    courseid:{
        type:String,
    },
    v:[{
        type:String,
    }],
    q:[{
        type:String,
    }],
});

const startedModel = db.model('started',startedSchema);
module.exports = startedModel;
