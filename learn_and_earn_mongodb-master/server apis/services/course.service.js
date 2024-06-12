const coursemodel = require('../model/course.modal');

class courseService{
    static async registercourse(img,des,rating,student,title,ins,type){
        try{
            const cretequiz = new coursemodel({img,des,rating,student,title,ins,type});
            return await cretequiz.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async getall(){
    try{
        return await coursemodel.find();
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

   static async getcoursebyid(id){
    try{
        return await coursemodel.findById(id);
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

   static async getbyname(title){
    try{
        return await coursemodel.findOne({title});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

   static async getcoursebyid(id){
    try{
        return await coursemodel.findById(id);
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }

   static async deletecourse(id){
    try{
        return await coursemodel.findByIdAndDelete(id);
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }
}

module.exports = courseService;
