const classmodel = require('../model/class.modal');
const app = require('express').Router();

app.post('/registerclass', async (req, res, next) => {
    try {
      const { name, des, date, time, addedby } = req.body;
      const newChat = new classmodel({ name, des, date, time, addedby });
      await newChat.save();
      res.status(200).json({ status: true, message: 'register sucessfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: false, message: 'try again later' });
    }
});

app.post('/allclassbyid', async (req, res, next) => {
    try {
      const {addedby} = req.body;
      const user = await classmodel.find({addedby:addedby});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/allclass', async (req, res, next) => {
    try {
      const user = await classmodel.find();
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});


app.post('/deleteclass', async (req, res, next) => {
    try {
      const {id} = req.body;
      await classmodel.findByIdAndDelete(id);
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false});
    }
});

module.exports = app;