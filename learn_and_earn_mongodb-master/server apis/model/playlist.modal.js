const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const playlistSchema = new Schema({
    courseid:{
        type:String,
    },
    img:{
        type:String,
    },
    des:{
        type:String,
    },
    title:{
        type:String,
    },
    vid:{
        type:String,
    },
    qid:{
        type:String,
    },
    user:[
        {
            type:String,
        }
    ]
});

const playlistModel = db.model('playlist',playlistSchema);
module.exports = playlistModel;
