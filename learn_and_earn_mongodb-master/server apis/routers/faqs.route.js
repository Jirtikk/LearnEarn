const faqs = require('../model/faqs.modal');
const app = require('express').Router();

app.post('/registerfaqs', async (req, res, next) => {
    try {
      const { title, ans} = req.body;
      const user = new faqs({ title, ans});
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});


app.post('/allfaqs', async (req, res, next) => {
    try {
      const user = await faqs.find();
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});


module.exports = app;