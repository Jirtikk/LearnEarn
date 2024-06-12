// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../tools/applayout.dart';

 const url = 'https://learn-and-earn.glitch.me/';
//const url = 'http://10.0.2.2:3000/';

const registrationlink = "${url}register";
const loginlink = "${url}login";
const adveerink = "${url}getall";
const courseink = "${url}getallcourse";
const courseplaylistink = "${url}getcourseplaylist";
const getoneuserdatalink = "${url}getoneuserdata";
const alluserlink = "${url}alluser";
const deleteuserlink = "${url}deleteuser";

// community
const registercommunitylink = "${url}registercommunity";
const getallcommunitylink = "${url}getallcommunity";

// started
const registerstartedlink = "${url}registerstarted";
const getstarteduniquelink = "${url}getstartedunique";
const getstartedlengthlink = "${url}getstartedlength";
const addtovlistlink = "${url}addtovlist";
const addtoqlistlink = "${url}addtoqlist";
const getstartedbynumlink = "${url}getstartedbynum";

// quiz
const getonequizlink = "${url}getonequiz";
const updateuserslink = "${url}updateusers";
const registerquizlink = "${url}registerquiz";
const registercourselink = "${url}registercourse";
const getcoursebyidlink = "${url}getcoursebyid";
const registerplaylistlink = "${url}registerplaylist";
const getonequizdatalink = "${url}getonequizdata";
const getcerlink = "${url}getcer";

// job
const registerjoblink = "${url}registerjob";
const getalljoblink = "${url}getalljob";
const updatejoblink = "${url}updatejob";

// job aplies
const registerjobappliedlink = "${url}registerjobapplied";
const getalljobappliedlink = "${url}getalljobapplied";
const updatejobappliedlink = "${url}updatejobapplied";
const getjobappliedbylink = "${url}getjobappliedby";

// faqs
const allfaqslink = "${url}allfaqs";
const registerfaqslink = "${url}registerfaqs";

// request
const registerrequestlink = "${url}registerrequest";
const allrequestbyidlink = "${url}allrequestbyid";
const changerequeststatuslink = "${url}changerequeststatus";
const giverequestlink = "${url}giverequest";

// class
const registerclasslink = "${url}registerclass";
const allclassbyidlink = "${url}allclassbyid";
const allclasslink = "${url}allclass";
const deleteclasslink = "${url}deleteclass";
const deletecourselink = "${url}deletecourse";
const deletejoblink = "${url}deletejob";

class ApiHelper {
  // request
  static Future<bool> registerrequest(
      String uid, String iid, BuildContext context) async {
    try {
      AppLayout.displayprogress(context);
      var response = await http.post(Uri.parse(registerrequestlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "iid": iid,
            "status": "new",
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      AppLayout.hideprogress(context);
      bool s = data['status'] as bool;
      if (s) {
        return data['move'] as bool;
      } else {
        return false;
      }
    } catch (e) {
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, "Try again later");
      return false;
    }
  }

  static Future<List> allrequestbyid(String iid) async {
    try {
      var response = await http.post(Uri.parse(allrequestbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"iid": iid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<Map> giverequest(String uid, String iid) async {
    try {
      var response = await http.post(Uri.parse(giverequestlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid, "iid": iid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<bool> changerequeststatus(
      String uid, String iid, BuildContext context) async {
    try {
      AppLayout.displayprogress(context);
      var response = await http.post(Uri.parse(changerequeststatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid, "iid": iid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      AppLayout.hideprogress(context);
      return data['status'];
    } catch (e) {
      AppLayout.hideprogress(context);
      return false;
    }
  }

  // class
  static Future<bool> registerclass(String name, String des, String date,
      String time, String addedby, BuildContext context) async {
    try {
      AppLayout.displayprogress(context);
      var response = await http.post(Uri.parse(registerclasslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": name,
            "des": des,
            "date": date,
            "time": time,
            "addedby": addedby
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, data['message']);
      return data['status'] as bool;
    } catch (e) {
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, "Try again later");
      return false;
    }
  }

  static Future<List> allclassbyid(String addedby) async {
    try {
      var response = await http.post(Uri.parse(allclassbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"addedby": addedby}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<Map> getcoursebyid(String id) async {
    try {
      var response = await http.post(Uri.parse(getcoursebyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> allclass() async {
    try {
      var response = await http.post(Uri.parse(allclasslink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteclass(String id, BuildContext context) async {
    try {
      AppLayout.displayprogress(context);
      var response = await http.post(Uri.parse(deleteclasslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      AppLayout.hideprogress(context);
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deletecourse(String id, BuildContext context) async {
    try {
      AppLayout.displayprogress(context);
      var response = await http.post(Uri.parse(deletecourselink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      AppLayout.hideprogress(context);
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deletejob(String id, BuildContext context) async {
    try {
      AppLayout.displayprogress(context);
      var response = await http.post(Uri.parse(deletejoblink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      AppLayout.hideprogress(context);
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteuser(String id, BuildContext context) async {
    try {
      AppLayout.displayprogress(context);
      var response = await http.post(Uri.parse(deleteuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      AppLayout.hideprogress(context);
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<List> alluser() async {
    try {
      var response = await http.post(Uri.parse(alluserlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> registration(
      String number,
      String edu,
      String gender,
      String img,
      String name,
      String pass,
      String useras,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registrationlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "edu": edu,
            "gender": gender,
            "img": img,
            "name": name,
            "pass": pass,
            "useras": useras
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      AppLayout.showsnakbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, "Try again later");
      return false;
    }
  }

  static Future<Map> login(
      String number, String pass, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(loginlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "pass": pass,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(data['token']);
        return decodedToken;
      } else {
        AppLayout.hideprogress(context);
        AppLayout.showsnakbar(context, data['message']);
        return {};
      }
    } catch (e) {
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, "Try again later");
      return {};
    }
  }

  static Future<Map> getoneuserdata(BuildContext context, String number) async {
    try {
      var response = await http.post(Uri.parse(getoneuserdatalink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'] as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<void> addtovlist(
      BuildContext context, String number, courseid, vid) async {
    try {
      var response = await http.post(Uri.parse(addtovlistlink),
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode({"number": number, "courseid": courseid, "vid": vid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {}
  }

  static Future<bool> addtoqlist(
      BuildContext context, String number, courseid, vid) async {
    try {
      var response = await http.post(Uri.parse(addtoqlistlink),
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode({"number": number, "courseid": courseid, "vid": vid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'];
    } catch (e) {
      return false;
    }
  }

  static Future<List> adver() async {
    try {
      var response = await http.post(
        Uri.parse(adveerink),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> course() async {
    try {
      var response = await http.post(
        Uri.parse(courseink),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> courseplaylist(String courseid) async {
    try {
      var response = await http.post(Uri.parse(courseplaylistink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"courseid": courseid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> registercommunity(String text, String time, String name,
      String imgp, String img, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registercommunitylink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "text": text,
            "time": time,
            "imgp": imgp,
            "name": name,
            "img": img,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      AppLayout.showsnakbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, "Try again later");
      return false;
    }
  }

  static Future<bool> registercourse(String img, String des, String title,
      String ins, String type, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registercourselink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "img": img,
            "des": des,
            "rating": "0",
            "student": "0",
            "title": title,
            "ins": ins,
            "type": type
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      AppLayout.showsnakbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, "Try again later");
      return false;
    }
  }

  static Future<Map> registerquiz(String courseid, String duration,
      List questionanswer, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerquizlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "courseid": courseid,
            "duration": duration,
            "questionanswer": questionanswer,
            "user": []
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data;
    } catch (e) {
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, 'try again later');
      return {};
    }
  }

  static Future<Map> registerplaylist(String courseid, String img, String des,
      String title, String vid, String qid, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerplaylistlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "courseid": courseid,
            "img": img,
            "des": des,
            "title": title,
            "vid": vid,
            "qid": qid,
            "user": []
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data;
    } catch (e) {
      AppLayout.hideprogress(context);
      AppLayout.showsnakbar(context, 'try again later');
      return {};
    }
  }

  static Future<List> getallcommunity() async {
    try {
      var response = await http.post(
        Uri.parse(getallcommunitylink),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> getstartedbynum(String number) async {
    try {
      var response = await http.post(Uri.parse(getstartedbynumlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> getstartedlength(String number, String courseid) async {
    try {
      var response = await http.post(Uri.parse(getstartedlengthlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number, "courseid": courseid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> registerstarted(
      String number, String courseid, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerstartedlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "courseid": courseid,
            "v": [],
            "q": [],
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<List> getstartedunique(String number) async {
    try {
      var response = await http.post(Uri.parse(getstarteduniquelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<Map> getonequiz(String courseid, String number) async {
    try {
      var response = await http.post(Uri.parse(getonequizlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'courseid': courseid, "number": number}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> getonequizdata(String courseid) async {
    try {
      var response = await http.post(Uri.parse(getonequizdatalink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'courseid': courseid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['quiz'];
    } catch (e) {
      return {};
    }
  }

  static Future<bool> updateusers(String courseid, String number) async {
    try {
      var response = await http.post(Uri.parse(updateuserslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'courseid': courseid, "number": number}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getcer() async {
    try {
      var response = await http.post(Uri.parse(getcerlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['link'] as String;
    } catch (e) {
      return "";
    }
  }

  static Future<bool> registerjob(String addedby, String title, String des,
      String companyname, String salary, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerjoblink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "addedby": addedby,
            "title": title,
            "des": des,
            "companyname": companyname,
            "salary": salary,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatejob(String id, String title, String des,
      String salary, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatejoblink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "title": title,
            "des": des,
            "salary": salary,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<List> getalljob(BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(getalljoblink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'] as List;
    } catch (e) {
      return [];
    }
  }

  // job applied
  static Future<bool> registerjobapplied(
      String addedby,
      String title,
      String des,
      String companyname,
      String salary,
      String appliedby,
      String resume,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerjobappliedlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "addedby": addedby,
            "title": title,
            "des": des,
            "companyname": companyname,
            "salary": salary,
            "appliedby": appliedby,
            "status": "new",
            "date": "",
            "time": "",
            "resume": resume
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<List> getalljobapplied(BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(getalljobappliedlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<List> getjobappliedby(
      BuildContext context,
      String appliedby,
      String addedby,
      String title,
      String des,
      String companyname,
      String salary) async {
    try {
      var response = await http.post(Uri.parse(getjobappliedbylink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "appliedby": appliedby,
            "addedby": addedby,
            "title": title,
            "des": des,
            "companyname": companyname,
            "salary": salary
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> updatejobapplied(String addedby, String appliedby,
      String status, String date, String time, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatejobappliedlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "addedby": addedby,
            "appliedby": appliedby,
            "status": status,
            "date": date,
            "time": time,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // faqs
  static Future<List> allfaqs(BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(allfaqslink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> registerfaqs(
      String title, String ans, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerfaqslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "title": title,
            "ans": ans,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      AppLayout.showsnakbar(context, data['message']);
      return data['status'] as bool;
    } catch (e) {
      AppLayout.showsnakbar(context, "Try again later");
      return false;
    }
  }
}
