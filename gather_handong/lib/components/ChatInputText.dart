import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/controller/ChatRoomController.dart';
import 'package:gather_handong/model/ChatRoom.dart';
import 'package:gather_handong/model/Message.dart';

class ChatInputText extends StatefulWidget {
  const ChatInputText({Key? key, required this.chatRoom}) : super(key: key);

  final DocumentSnapshot<Object?>? chatRoom;

  @override
  State<ChatInputText> createState() => _ChatInputText();
}

class _ChatInputText extends State<ChatInputText> {
  TextEditingController _textController = TextEditingController();

  void _handleSubmitted(text) {
    if (text == "") return;
    _textController.clear();

    List<dynamic> messagesDynamic = widget.chatRoom?.get('messages') ?? [];
    List<String> users = List.from(widget.chatRoom?.get('users') ?? []);

    List<Map<String, String>> messages = messagesDynamic
        .map((messageMap) => Map<String, String>.from(messageMap))
        .toList();

    messages.add({
      'content': text,
      'idFrom': FirebaseAuth.instance.currentUser!.uid,
      'idTo': users[0] == FirebaseAuth.instance.currentUser!.uid
          ? users[1]
          : users[0]
    });

    print(messages);

    ChatRoomController.chatroomUpdate(ChatRoom(
        chatRoomId: widget.chatRoom?.get('chatRoomId'),
        users: users,
        messages: messages));
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text)),
              ),
            ],
          )),
    );
  }
}
