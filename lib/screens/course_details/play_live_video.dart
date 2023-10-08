import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:classroom_toppers/utils/strings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/chat_create_model/chat_data.dart';
import '../../utils/sharedpref.dart';
import '../chat/chat_screen.dart';

class PlayLiveVideo extends StatefulWidget {
  PlayLiveVideo({Key? key}) : super(key: key);

  @override
  State<PlayLiveVideo> createState() => _PlayLiveVideoState();
}

class _PlayLiveVideoState extends State<PlayLiveVideo> {
  var videoId = Get.arguments[0].toString();
  var Live = Get.arguments[1].toString();
  List<ChatData> chatMessages =
      []; // Replace this list with your actual chat message list
  TextEditingController _messageController = TextEditingController();

  var loading = false;
  late String id;

  late bool isLandscape;

  @override
  void dispose() {
    disposeData();
    super.dispose();
  }

  disposeData() async {
    await app.appController.loadMsg(videoId, 'stop');

    //sending user offline
    await app.appController.liveUserCount(videoId, OfflineUser);

    _messageController.dispose();
    _videoCntrl.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var userId = await SharedPref().getUserId();
    setState(() {
      id = userId.toString();
    });

//sending user online
    await app.appController.liveUserCount(videoId, OnlineUser);
  }

  YoutubePlayerController _videoCntrl = YoutubePlayerController(
    initialVideoId: Get.arguments[1].toString().split("/").last,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      isLive: true,
      hideControls: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      // Check if the device is in landscape mode
      isLandscape = orientation == Orientation.landscape;
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          // backgroundColor: appColor.black,
          body: player(),
        ),
      );
    });
  }

  Widget player() {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: YoutubePlayer(
            // aspectRatio: 2.00,
            controller: _videoCntrl,
            showVideoProgressIndicator: true,

            // videoProgressIndicatorColor: Colors.amber,
            // progressColors: ProgressColors(
            //     playedColor: Colors.amber,
            //     handleColor: Colors.amberAccent,
            // ),
            // onReady () {
            //     _controller.addListener(listener);
            // },
          ),
        ),
        if (!isLandscape)
          Flexible(
              flex: 5,
              child:
                  // chatScreen()
                  LiveChatScreen(
                videoId: videoId,
              )),
      ],
    );
  }

  // Widget chatScreen() {
  //   return FutureBuilder<List<dynamic>>(
  //       future: Future<List<dynamic>>.value(
  //         Future.wait([
  //           app.appController.getChat(videoId),
  //         ]),
  //       ),
  //       builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return SpinKitCircle(
  //             color: appColor.grey,
  //           );
  //         } else {
  //           if (snapshot.hasError) {
  //             return Text('Error: ${snapshot.error}');
  //           } else {
  //             // chatMessages = app.appController.chatDataList;
  //             if (chatMessages == null) {
  //               return Container();
  //             } else {
  //               // return a widget to handle the null case
  //               return Column(
  //                 children: [
  //                   Expanded(
  //                     child: ListView.builder(
  //                       shrinkWrap: true,
  //                       itemCount: chatMessages.length,
  //                       itemBuilder: (context, index) {
  //                         // bool isSender = chatMessages[index].senderId == id;

  //                         bool isSender = false;

  //                         return ChatBubble(
  //                           message: chatMessages[index].message.toString(),
  //                           isSender: isSender,
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   // loading ? Center(child: WidgetUtil.loader()) : Container(),
  //                   _buildMessageBox(),
  //                 ],
  //               );
  //             }
  //           }
  //         }
  //       });
  // }

  // Widget _buildMessageBox() {
  //   return Container(
  //     height: 50,
  //     padding: EdgeInsets.symmetric(horizontal: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.grey[100],
  //       border: Border.all(color: Colors.grey),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             controller: _messageController,
  //             decoration: InputDecoration.collapsed(
  //               hintText: 'Ask any doubt/question...',
  //             ),
  //           ),
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.send),
  //           onPressed: () async {
  //             String message = _messageController.text.trim();
  //             if (message.isNotEmpty) {
  //               //sending msg
  //               await app.appController.createChat(videoId, message);

  //               // setState(() {
  //               //   _messageController.clear();
  //               // });
  //               ;
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
