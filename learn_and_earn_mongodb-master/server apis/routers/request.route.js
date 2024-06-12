const requestmodel = require('../model/request.modal');
const app = require('express').Router();

app.post('/registerrequest', async (req, res, next) => {
    try {
      const { uid,iid,status } = req.body;
      const a = await requestmodel.findOne({uid,iid});
      if (a) {
        if(a.status === "new"){
            res.status(200).json({ status: true, move: false });
        } else {
            res.status(200).json({ status: true, move: true });
        }
      } else {
        const newChat = new requestmodel({ uid,iid,status });
        await newChat.save();
        res.status(200).json({ status: true, move: false });
      }
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: false});
    }
});

app.post('/allrequestbyid', async (req, res, next) => {
    try {
      const {iid} = req.body;
      const user = await requestmodel.find({iid:iid});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});


app.post('/changerequeststatus', async (req, res, next) => {
    try {
      const {uid,iid} = req.body;
       await requestmodel.findOneAndUpdate({uid,iid},{$set:{status:"accepted"}});
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false});
    }
});


app.post('/giverequest', async (req, res, next) => {
  try {
    const {uid,iid} = req.body;
    const a = await requestmodel.findOne({uid,iid});
    res.status(200).json({ status:true,data:a});
  } catch (error) {
    console.log(error);
    res.status(500).json({ status:false,data:{}});
  }
});

module.exports = app;