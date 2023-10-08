import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/app_color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideo extends StatefulWidget {
  PlayVideo({Key? key}) : super(key: key);

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  var Live = Get.arguments[1].toString();

  @override
  void initState() {
    super.initState();
    print("url>>" + Get.arguments);
  }

  @override
  void dispose() {
    _videoCntrl.dispose();
    super.dispose();
  }

  YoutubePlayerController _videoCntrl = YoutubePlayerController(
    initialVideoId: Get.arguments.toString().split("/").last,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      hideControls: false,
      forceHD: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.black,
      body: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.fitWidth,
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
      ),
    );
  }
}
