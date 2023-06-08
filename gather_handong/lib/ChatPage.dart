import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/components/ButtomNavBar.dart';
import 'package:gather_handong/components/ChatBubbleWidget.dart';
import 'package:gather_handong/controller/ChatRoomController.dart';
import 'package:gather_handong/model/ChatRoom.dart';
import 'package:gather_handong/model/Message.dart';

import 'components/ChatInputText.dart';

class ChatPage extends StatefulWidget {
  String selectedChatRoomId;

  ChatPage({Key? key, required this.selectedChatRoomId}) : super(key: key);

  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  late bool isShowSticker;
  late bool isShowKeyboard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      bottomNavigationBar: ButtomNavBar(),
      appBar: AppBar(
        title: Text('채팅'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: BuildListMessage(widget.selectedChatRoomId),
    );
  }
}

class BuildListMessage extends StatelessWidget {
  BuildListMessage(this.groupChatId, {Key? key}) : super(key: key);

  final String groupChatId;

  @override
  Widget build(BuildContext context) {
    ScrollController listScrollController = ScrollController();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(groupChatId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else {
          List<Map<String, dynamic>> listMessage =
              List<Map<String, dynamic>>.from(
                  snapshot.data!.get('messages').reversed.toList());

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) {
                    var messageData = listMessage[index];
                    var message = Message.fromJson(messageData);

                    return ChatBubbleWidget(
                      content: message.content,
                      idFrom: message.idFrom,
                    );
                  },
                  itemCount: listMessage.length,
                  reverse: true,
                  controller: listScrollController,
                ),
              ),
              ChatInputText(chatRoom: snapshot.data),
            ],
          );
        }
      },
    );
  }
}
