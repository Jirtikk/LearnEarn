import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:learn_and_earn_mongodb/tools/top.dart';

class instructorvideo extends StatefulWidget {
  instructorvideo(
      {super.key,
      required this.cdata,
      required this.courseid,
      required this.number});
  Map cdata;
  String courseid;
  String number;

  @override
  State<instructorvideo> createState() => _instructorvideoState();
}

class _instructorvideoState extends State<instructorvideo> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.cdata['vid'])
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.wh,
      body: SafeArea(
          child: Column(
        children: [
          top(title: "${widget.cdata['title']}"),
          Expanded(
            child: CustomVideoPlayer(
                customVideoPlayerController: _customVideoPlayerController),
          ),
        ],
      )),
    );
  }
}
