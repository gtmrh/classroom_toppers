import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:classroom_toppers/utils/theme.dart';
import '../../model/chat_list_model/chat_list_data.dart';
import '../../utils/app_color.dart';
import '../../utils/my_application.dart';
import '../../utils/sharedpref.dart';
import 'chat_bubble.dart';
import 'package:get/get.dart';

class LiveChatScreen extends StatefulWidget {
  String videoId;
  LiveChatScreen({super.key, required this.videoId});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  List<ChatListData> chatMessages = [];
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  var loading = false;
  late String id;

  bool userScrolling = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          userScrolling = true;
        });
      } else {
        setState(() {
          userScrolling = false;
        });
      }
    });

    super.initState();
  }

  getData() async {
    var userId = await SharedPref().getUserId();
    setState(() {
      id = userId.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return view();
  }

  Widget view() {
    return Stack(
      children: [
        Obx(() {
          chatMessages = app.appController.chatListData;

          if (chatMessages.isEmpty) {
            return Center(
              child: Text(
                'waiting for message...',
                style: AppTheme.ttlStyl12,
              ),
            );
            // SpinKitCircle(
            //   color: appColor.grey,
            // );
          } else {
            // scrollToLastMessage();

            return Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      controller: _scrollController,
                      // shrinkWrap: true,
                      // reverse: true,
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        print("id>>${id}");
                        bool isSender = chatMessages[index].userId == id;
                        // scrollToLastMessage();

                        return ChatBubble(
                          chatData: chatMessages[index],
                          isSender: isSender,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        }),
        // loading ? Center(child: WidgetUtil.loader()) : Container(),
        Align(alignment: Alignment.bottomCenter, child: _buildMessageBox()),
      ],
    );
  }

  Widget _buildMessageBox() {
    return Container(
      height: 50,
      // margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration.collapsed(
                hintText: 'Ask any doubt/question...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              String message = _messageController.text.trim();
              if (message.isNotEmpty) {
                //sending msg
                await app.appController.createChat(widget.videoId, message);
                await app.appController.getChatList(widget.videoId);

                setState(() {
                  _messageController.clear();
                });
                scrollToLastMessage();
              }
            },
          ),
        ],
      ),
    );
  }

  scrollToLastMessage() {
    // if (!userScrolling) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
    // }
  }
}
