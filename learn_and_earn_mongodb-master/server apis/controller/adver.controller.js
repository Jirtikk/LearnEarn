const adverService = require('../services/adver.service');

exports.getalldata = async(req,res,next)=>{
    try{
        const a = await adverService.getall();
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

