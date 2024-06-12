const usermodel = require('../model/user.modal');
const jwt = require("jsonwebtoken");

class UserService{
   static async registerUser(number,edu,gender,img,name,pass,useras){
        try{
            const creteuser = new usermodel({number,edu,gender,img,name,pass,useras});
            return await creteuser.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async checkuser(number){
    try{
        return await usermodel.findOne({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async generateToken(tokenData,secretKey,jwt_expiry){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expiry});
   }

   static async deleteuser(id){
    try{
        return await usermodel.findByIdAndDelete(id);
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

   static async alluser(){
    try{
        return await usermodel.find();
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

}

module.exports = UserService;