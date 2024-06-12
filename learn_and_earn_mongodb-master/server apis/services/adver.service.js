const advermodel = require('../model/adver.modal');

class adverService{
   static async getall(){
    try{
        return await advermodel.find();
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }
}

module.exports = adverService;