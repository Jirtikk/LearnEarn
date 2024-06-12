const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const faqsSchema = new Schema({
    title:{
        type:String,
    },
    ans:{
        type:String,
    },
});

const faqsModel = db.model('faqs',faqsSchema);
module.exports = faqsModel;
