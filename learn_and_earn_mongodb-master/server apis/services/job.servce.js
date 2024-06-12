const jobmodel = require('../model/job.modal');

class jobService{
    static async registerjob(addedby,title,des,companyname,salary){
         try{
             const cretejob = new jobmodel({addedby,title,des,companyname,salary});
             return await cretejob.save();
         } catch(e){
             console.log(e)
             res.json({status:false,sucess:"server error service register"});
         }
    }

    static async getalljob(){
        try{
            return await jobmodel.find();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async updatejob(id,title,des,salary){
    try{
        return await jobmodel.findByIdAndUpdate(id,{title:title,des:des,salary:salary});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service register"});
    }
}

static async deletejob(id){
    try{
        return await jobmodel.findByIdAndDelete(id);
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

}
 
module.exports = jobService;