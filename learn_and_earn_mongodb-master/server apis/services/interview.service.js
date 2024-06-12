const interviewmodel = require('../model/interview.modal');

class interviewService{
    static async interviewmodelreg(added,date,time,applied,test,result){
         try{
             const cretejob = new interviewmodel({added,date,time,applied,test,result});
             return await cretejob.save();
         } catch(e){
             console.log(e)
             res.json({status:false,sucess:"server error service register"});
         }
    }

    static async getallinterview(){
        try{
            return await interviewmodel.find();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async getoneinterviewadded(added){
    try{
        return await interviewmodel.find({added});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service register"});
    }
    }


    static async getoneinterviewapplied(applied){
        try{
            return await interviewmodel.find({applied});
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
        }


}
 
module.exports = interviewService;