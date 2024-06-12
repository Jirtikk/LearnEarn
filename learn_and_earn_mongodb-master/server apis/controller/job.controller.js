const jobService = require('../services/job.servce');

exports.registerjob = async(req,res,next)=>{
    try{
        const {addedby,title,des,companyname,salary} = req.body;
        await jobService.registerjob(addedby,title,des,companyname,salary);
        res.json({status:true,sucess:"job registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.getalljob = async(req,res,next)=>{
    try{
        const a = await jobService.getalljob();
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.updatejob = async(req,res,next)=>{
    try{
        const {id,title,des,salary} = req.body;
        await jobService.updatejob(id,title,des,salary);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
}


exports.deletejob = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const a = await jobService.deletejob(id);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
}