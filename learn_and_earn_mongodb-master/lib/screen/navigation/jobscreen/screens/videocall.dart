// Instantiate the client
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  CallPage({Key? key, required this.callID,
    required this.username, required this.userid}) : super(key: key);
  String callID,username,userid;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: ZegoUIKitPrebuiltCall(
        appID: 743871215,
        appSign: "012ca559cb5a2955a9113414c0c7613f3c87a88b64b9d80a273bb9dc947b67cd",
        userID: userid,
        userName: username,
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ),
    );
  }
}