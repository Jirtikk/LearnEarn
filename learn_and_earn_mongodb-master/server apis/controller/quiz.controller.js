const quizService = require('../services/quiz.service');

exports.registerquiz = async(req,res,next)=>{
    try{
        const {courseid,duration,questionanswer,user} = req.body;
        const response = await quizService.registerquiz(courseid,duration,questionanswer,user);
        res.json({status:true,sucess:"Quiz registered Sucessfully",id:response._id});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getonequizdata = async(req,res,next)=>{
    try{
        const {courseid} = req.body;
        const quiz = await quizService.getonequiz(courseid);
        res.status(200).json({quiz});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.getonequiz = async(req,res,next)=>{
    try{
        const {courseid,number} = req.body;
        const quiz = await quizService.getonequiz(courseid);
        let check = false;
        for (let i = 0; i < quiz.user.length; i++) {
            const item = quiz.user[i];
            if(item.includes(number)){
                check = true
                break
            } else{
                check = false
            }
        }
        if(check){
            res.status(200).json({status:true,message:"already give"});
        } else{
            res.status(200).json({status:false,message:"quiz fetch sucessfully"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.updateusers = async(req,res,next)=>{
    try{
        const {courseid,number} = req.body;
        const quiz = await quizService.getonequiz(courseid);
        quiz.user.push(number)
        await quizService.updateusers(courseid,quiz.user);
        res.status(200).json({status:true,message:"ok"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.getcer = async(req,res,next)=>{
    try{
        res.status(200).json({link:"https://firebasestorage.googleapis.com/v0/b/learn-and-earn-77d0b.appspot.com/o/certificate%2FLearn%20%26%20Earn%20Certificate.png?alt=media&token=dce3828e-848e-4cf8-bbd1-0bd6b1b9f6e5"});
    } catch (e){
        res.json({status:false,sucess:"server error controller login"});
    }
}

