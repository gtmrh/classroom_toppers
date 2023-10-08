import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:classroom_toppers/model/chat_list_model/chat_list_data.dart';

class ChatBubble extends StatelessWidget {
  final ChatListData chatData;
  final bool
      isSender; // true if the message is sent by the user, false otherwise

  ChatBubble({required this.chatData, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      alignment: isSender ? Alignment.bottomRight : Alignment.centerLeft,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chatData.username.toString(),
            style: TextStyle(
              color: isSender ? Colors.white : Colors.black,
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontSize: 12,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSender ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              chatData.message.toString(),
              style: TextStyle(
                color: isSender ? Colors.white : Colors.black,
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
