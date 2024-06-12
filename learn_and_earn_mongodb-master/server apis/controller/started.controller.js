const startedService = require('../services/started.service');
const courseService = require('../services/course.service');
const playlistService = require('../services/playlist.service');

exports.registerstarted = async(req,res,next)=>{
    try{
        const {number,courseid,v,q} = req.body;

        let add = false;
        const data = await startedService.getstarted(number,courseid)

        for (let i = 0; i < data.length; i++) {
            const item = data[i]; 
            if(item.courseid === courseid){
                add = false;
                break;
            } else{
                add = true;
            }
        }

        if(add){
            await startedService.registerstarted(number,courseid,v,q);
            res.json({status:true,sucess:"started registered Sucessfully"});
        } else{
            if(data.length === 0){
                await startedService.registerstarted(number,courseid,v,q);
                res.json({status:true,sucess:"started registered Sucessfully"});
            } else {
                res.json({status:false,sucess:"started registered Sucessfully"});
            }
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getstartedlength = async(req,res,next)=>{
    try{
        const {number,courseid} = req.body;
        const a = await startedService.getstartedlength(number,courseid);
        if(!a){
            res.status(200).json({status:false,message:"no data found",data:[]});
        } else{
            res.status(200).json({status:true,data:a});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,message:"server error controller login",data:[]});
    }
}

exports.getstartedbynum = async (req, res, next) => {
    try {
        const { number } = req.body;
        const startedData = await startedService.getstartedbynum(number);

        const modifiedStartedData = []; 

        for (let i = 0; i < startedData.length; i++) {
            const entry = startedData[i];
            
            const courseData = await courseService.getcoursebyid(entry.courseid);
            const playlistData = await playlistService.getany(entry.courseid);
            const playlistLength = playlistData.length;
            
            const modifiedEntry = {
                _id: entry._doc._id,
                number: entry._doc.number,
                courseid: entry._doc.courseid,
                v: entry._doc.v,
                q: entry._doc.q,
                courseData: courseData,
                playlistLength: playlistLength
            };

            modifiedStartedData.push(modifiedEntry);
        }

        res.status(200).json({ status: true, data: modifiedStartedData });
    } catch (e) {
        console.log(e);
        res.json({ status: false, message: "Server error in controller login", data: [] });
    }
}




exports.addtovlist = async(req,res,next)=>{
    try{
        const {number,courseid,vid} = req.body;

        let add = false;
        const data = await startedService.getstarted(number,courseid)
        let ii = {};

        for (let i = 0; i < data.length; i++) {
            const item = data[i]; 
            if(item.v.includes(vid)){
                add = false;
                break;
            } else{
                ii = item;
                add = true;
            }
        }

        if (add) {
            ii.v.push(vid);
            await startedService.addtovlist(number,courseid,ii.v);
        }
    } catch (e){
        console.log(e)
    }
}

exports.addtoqlist = async(req,res,next)=>{
    try{
        const {number,courseid,vid} = req.body;

        let add = false;
        const data = await startedService.getstarted(number,courseid)
        let ii = {};

        for (let i = 0; i < data.length; i++) {
            const item = data[i]; 
            if(item.q.includes(vid)){
                add = false;
                break;
            } else{
                ii = item;
                add = true;
            }
        }

        if (add) {
            ii.q.push(vid);
            await startedService.addtoqlist(number,courseid,ii.q);
            res.status(200).json({status:true});
        }
    } catch (e){
        console.log(e)
        res.status(200).json({status:false});
    }
}


exports.getstartedunique = async(req,res,next)=>{
    try{
        const {number} = req.body;
        const data = await startedService.getstartedbynumber(number);
        let f = [];
        for (let i = 0; i < data.length; i++) {
            const item = data[i]; 
            if(!f.includes(item.title)){
                f.push(item.title)
            }
        }
        
        let ff = [];
        for (let i = 0; i < f.length; i++) {
            const item = f[i]; 
            const a = await startedService.getstartedlength(number,item);
            const d = await courseService.getbyname(item);
            const aut = await playlistService.getany(d._id.toString());
            ff.push({'title':item,'length':a.length-1,'autl':aut.length,'data':d,})
        }

        res.status(200).json({status:true,data:ff});    
    } catch (e){
        console.log(e)
        res.json({status:false,message:"server error controller login"});
    }
}