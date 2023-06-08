import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gather_handong/model/Message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String content;
  final String idFrom;

  //  메세지 정보
  // 유저정보 currentuser
  // 비교 후
  // 나 이면 내쪽으로 아니면 상대방 쪽으로
  ChatBubbleWidget({required this.content, required this.idFrom});

  @override
  Widget build(BuildContext context) {
    return (idFrom == FirebaseAuth.instance.currentUser!.uid)
        ? Container(
            child: getSenderView(
                ChatBubbleClipper6(type: BubbleType.sendBubble),
                context,
                content),
          )
        : Container(
            child: getReceiverView(
                ChatBubbleClipper6(type: BubbleType.receiverBubble),
                context,
                content),
          );
  }

  getTitleText(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );

  getSenderView(CustomClipper clipper, BuildContext context, String text) =>
      ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Theme.of(context).colorScheme.shadow,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context, String text) =>
      ChatBubble(
        clipper: clipper,
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
