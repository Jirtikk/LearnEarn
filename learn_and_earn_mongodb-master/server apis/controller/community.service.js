const communityService = require('../services/community.service');

exports.registercommunity = async(req,res,next)=>{
    try{
        const {text,time,name,imgp,img} = req.body;
        const response = await communityService.registercommunity(text,time,name,imgp,img);
        res.json({status:true,sucess:"User registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getallcommunity = async(req,res,next)=>{
    try{
        const a = await communityService.getall();
        if(!a){
            res.status(200).json({status:false,message:"no data found"});
        } else{
            res.status(200).json({status:true,data:a});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,message:"server error controller login"});
    }
}

