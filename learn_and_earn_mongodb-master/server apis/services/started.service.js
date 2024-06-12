const startedmodel = require('../model/started.modek');

class startedService{
    static async registerstarted(number,courseid,v,q){
        try{
            const cretestarted = new startedmodel({number,courseid,v,q});
            return await cretestarted.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async getstartedlength(number,courseid){
    try{
        return await startedmodel.find({number:number,courseid:courseid});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

   static async getstartedbynumber(number){
    try{
        return await startedmodel.find({number});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

   static async getstarted(number,courseid){
    try{
        return await startedmodel.find({number,courseid});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }


   static async getstartedbynum(number){
    try{
        return await startedmodel.find({number});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }


   static async addtovlist(number,courseid,vid){
    try{
        return await startedmodel.findOneAndUpdate({number,courseid},{$set:{v:vid}});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }


   static async addtoqlist(number,courseid,qid){
    try{
        return await startedmodel.findOneAndUpdate({number,courseid},{$set:{q:qid}});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }


}

module.exports = startedService;
