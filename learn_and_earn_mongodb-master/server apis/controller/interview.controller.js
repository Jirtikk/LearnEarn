const interviewService = require('../services/interview.service');
const jobapliedService = require('../services/jobapplied.service');

exports.interviewmodelreg = async(req,res,next)=>{
    try{
        const {added,date,time,applied,test,result} = req.body;
        await interviewService.interviewmodelreg(added,date,time,applied,test,result);
        await jobapliedService.deletejobapplied(added,applied);
        res.json({status:true,sucess:"job registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.getallinterview = async(req,res,next)=>{
    try{
        const a = await interviewService.getallinterview();
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.getoneinterviewadded = async(req,res,next)=>{
    try{
        const {added} = req.body;
        const a = await interviewService.getoneinterviewadded(added);
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.getoneinterviewapplied = async(req,res,next)=>{
    try{
        const {applied} = req.body;
        const a = await interviewService.getoneinterviewapplied(applied);
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

