const communitymodel = require('../model/community.modal');

class communityService{
    static async registercommunity(text,time,name,imgp,img){
        try{
            const cretecommunity = new communitymodel({text,time,name,imgp,img});
            return await cretecommunity.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async getall(){
    try{
        return await communitymodel.find();
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

}

module.exports = communityService;
