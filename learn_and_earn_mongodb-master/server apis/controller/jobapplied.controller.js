const jobappliedService = require('../services/jobapplied.service');

exports.registerjobapplied = async(req,res,next)=>{
    try{
        const {addedby,title,des,companyname,salary,appliedby,status,date,time,resume} = req.body;
        await jobappliedService.registerjobapplied(addedby,title,des,companyname,salary,appliedby,status,date,time,resume);
        res.json({status:true,sucess:"job registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.updatejobapplied = async(req,res,next)=>{
    try{
        const {addedby,appliedby,status,date,time} = req.body;
        await jobappliedService.updatejobapplied(addedby,appliedby,status,date,time);
        res.status(200).json({status:true,data:"job updated Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.getalljobapplied = async(req,res,next)=>{
    try{
        const a = await jobappliedService.getalljobapplied();
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.getjobappliedby = async(req,res,next)=>{
    try{
        const {appliedby,addedby,title,des,companyname,salary} = req.body;
        const a = await jobappliedService.getjobappliedby(appliedby,addedby,title,des,companyname,salary);
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}
