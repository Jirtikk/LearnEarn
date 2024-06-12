const mongoose = require('mongoose');

//jirtikkumar7
//Y35ZmItNhGce3CDC
const connection = mongoose.createConnection('mongodb+srv://jirtikkumar7:Y35ZmItNhGce3CDC@cluster0.w9anffp.mongodb.net/?retryWrites=true&w=majority')
    .on('open',()=>{
    console.log('MongoDb connected');
}).on('error',()=>{
    console.log('MongoDb error');
});

module.exports = connection;
