const courseService = require('../services/course.service');

exports.registercourse = async(req,res,next)=>{
    try{
        const {img,des,rating,student,title,ins,type} = req.body;
        const response = await courseService.registercourse(img,des,rating,student,title,ins,type);
        res.json({status:true,sucess:"course registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getalldata = async(req,res,next)=>{
    try{
        const a = await courseService.getall();
        if(!a){
            res.status(200).json({status:false,message:"no data found"});
        } else{
            res.status(200).json({status:true,data:a});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.getcoursebyid = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const a = await courseService.getcoursebyid(id);
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,data:{}});
    }
}

exports.deletecourse = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const a = await courseService.deletecourse(id);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
}