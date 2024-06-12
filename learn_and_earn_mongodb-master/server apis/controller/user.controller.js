const UserService = require('../services/user.service');

exports.register = async(req,res,next)=>{
    try{
        const {number,edu,gender,img,name,pass,useras} = req.body;
        const response = await UserService.registerUser(number,edu,gender,img,name,pass,useras);
        res.json({status:true,sucess:"User registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.login = async(req,res,next)=>{
    try{
        const {number,pass} = req.body;
        
        const user = await UserService.checkuser(number);
        if(!user){
            res.status(200).json({status:false,message:"no user found"});
        } else{

            const isMatch = await user.comparePassword(pass);
            if(isMatch == false){
                res.status(200).json({status:false,message:"invalid password"});
            } else{
                let tokenData = {number:user.number,edu:user.edu,
                        img:user.img,name:user.name,useras:user.useras,gender:user.gender};
                const token = await UserService.generateToken(tokenData,"learnandearn","1h")
                res.status(200).json({status:true,token:token,message:"login in sucessfully"});
            }
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.getoneuserdata = async(req,res,next)=>{
    try{
        const {number} = req.body;
        const a = await UserService.checkuser(number);
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.deleteuser = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const a = await UserService.deleteuser(id);
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
}

exports.alluser = async(req,res,next)=>{
    try{
        const a = await UserService.alluser();
        res.status(200).json({status:true,data:a});
    } catch (e){
        console.log(e)
        res.json({status:false,data:[]});
    }
}