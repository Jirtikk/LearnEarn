const playlistmodel = require('../model/playlist.modal');

class playlistService{
    static async registerplaylist(courseid,img,des,title,vid,qid,user){
        try{
            const cretequiz = new playlistmodel({courseid,img,des,title,vid,qid,user});
            return await cretequiz.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async getany(courseid){
    try{
        return await playlistmodel.find({courseid});
    } catch(e){
        console.log(e)
        res.json({status:false,sucess:"server error service adver"});
    }
   }
}

module.exports = playlistService;
