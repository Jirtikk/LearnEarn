const playlistService = require('../services/playlist.service');

exports.registerplaylist = async(req,res,next)=>{
    try{
        const {courseid,img,des,title,vid,qid,user} = req.body;
        const response = await playlistService.registerplaylist(courseid,img,des,title,vid,qid,user);
        res.json({status:true,sucess:"Quiz registered Sucessfully",id:response._id});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getcourseplaylist = async(req,res,next)=>{
    try{
        const {courseid} = req.body;
        const a = await playlistService.getany(courseid);
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
