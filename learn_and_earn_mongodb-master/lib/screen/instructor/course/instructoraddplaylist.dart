import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_and_earn_mongodb/uihelpers/button_helper.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../firenasedatabasehelper/firebaseuploadhelper.dart';
import '../../../monoogshelper/mongoos.dart';
import '../../../tools/applayout.dart';
import '../../../tools/appstate.dart';
import '../../../uihelpers/text_veiw_helper.dart';

class instructoraddplaylist extends StatefulWidget {
  instructoraddplaylist({super.key, required this.courseid});
  String courseid = '';

  @override
  State<instructoraddplaylist> createState() => _instructoraddplaylistState();
}

class _instructoraddplaylistState extends State<instructoraddplaylist> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  File? image;

  Future<void> pic() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<File?> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  File? selectedVideo;
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (selectedVideo != null) {
      _initializeVideoPlayerFuture = _controller?.initialize().then((_) {
        _controller?.setLooping(true);
        setState(() {});
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Add New Data',style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: AppLayout.getwidth(context),
                  height: 280,
                  margin: const EdgeInsets.only(left: 20,top: 20, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  width: AppLayout.getwidth(context),
                  height: 280,
                  margin: const EdgeInsets.only(left: 10,top: 10, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ]
                  ),
                  child: InkWell(
                    onTap: ()=>pic(),
                    child: image == null ?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add,size: 80,),
                        Text("Click here to add course picture",style: GoogleFonts.roboto(),),
                      ],
                    ):
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        image!,
                        width: AppLayout.getwidth(context),
                        fit: BoxFit.cover,
                        height: 280,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: text_view_helper(hint: "Enter Video Name", controller: name,
                inputBorder: InputBorder.none,
                padding: const EdgeInsetsDirectional.all(0),
                margin: const EdgeInsetsDirectional.all(0),
                showicon: true,icon: const Icon(Icons.check_box_outline_blank_rounded),),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: text_view_helper(hint: "Enter Video Description", controller: description,
                inputBorder: InputBorder.none,
                padding: const EdgeInsetsDirectional.all(0),
                margin: const EdgeInsetsDirectional.all(0),
                showicon: true,icon: const Icon(Icons.check_box_outline_blank_rounded),),
            ),
            button_helper(onpress: () async {
              selectedVideo = await pickVideo();
              if (selectedVideo != null) {
                _controller = VideoPlayerController.file(selectedVideo!);
                _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
                  _controller!.setLooping(true);
                  setState(() {});
                });
              }
            }, color: Colors.amber, width: AppLayout.getwidth(context),
                child: Center(child: Text("Select Video",style: GoogleFonts.poppins(),))),
            selectedVideo != null
                ? FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
                : const SizedBox.shrink(),

            button_helper(onpress: () async {
              if (image == null) {
                AppLayout.showsnakbar(context, "select image");
              } else if (selectedVideo == null) {
                AppLayout.showsnakbar(context, "select video");
              } else if (name.text.isEmpty || description.text.isEmpty) {
                AppLayout.showsnakbar(context, "fill all fields");
              } else {
                AppLayout.displayprogress(context);
                String url = await FirebaseHelper.uploadFile(image, provider, provider.prefs.getString("phone"));
                String vurl = await FirebaseHelper.uploadFile(selectedVideo, provider, provider.prefs.getString("phone"));
                var data2 = await ApiHelper.registerplaylist(widget.courseid, url,
                    description.text, name.text, vurl, "", context);
                if (data2['status']) {
                  AppLayout.hideprogress(context);
                  Navigator.pop(context);
                  AppLayout.showsnakbar(context, "added successfully");
                } else {
                  AppLayout.hideprogress(context);
                  AppLayout.showsnakbar(context, "try again later");
                }
              }
            }, color: Colors.black, width: AppLayout.getwidth(context),
                child: Center(child: Text("Upload now",style: GoogleFonts.poppins(color: Colors.white,
                    fontWeight: FontWeight.bold),))),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
