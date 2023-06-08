import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/components/ChatBubbleWidget.dart';
import 'package:gather_handong/controller/ChatRoomController.dart';
import 'package:gather_handong/model/ChatRoom.dart';
import 'package:gather_handong/model/Message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  late bool isShowSticker;
  late bool isShowKeyboard;

  // Future<bool> onBackPress() {
  //   if (isShowSticker) {
  //     setState(() {
  //       isShowSticker = false;
  //     });
  //   } else {
  //     Navigator.pop(context);
  //   }
  //   return Future.value(false);
  // }

  // void getSticker() {
  //   // Hide keyboard when sticker appear
  //   // focusNode.unfocus();
  //   setState(() {
  //     isShowKeyboard = false;
  //   });
  //   setState(() {
  //     isShowSticker = !isShowSticker;
  //   });
  // }

  // void onFocusChange() {
  //   // if (focusNode.hasFocus) {
  //   if (isShowKeyboard) {
  //     // Hide sticker when keyboard appear
  //     setState(() {
  //       isShowSticker = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: BuildListMessage("LdJMGxObpwrwYtWi6z4V"),
    );
    // onWillPop: onBackPress);
  }
}

class BuildListMessage extends StatelessWidget {
  BuildListMessage(this.groupChatId, {Key? key}) : super(key: key);

  final String groupChatId;

  @override
  Widget build(BuildContext context) {
    ScrollController listScrollController = ScrollController();
    // TODO: implement build
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
        } else {
          var listMessage = snapshot.data!.get('messages') as List<dynamic>;
          print(listMessage);
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            // itemBuilder: (context, index) =>
            //     // buildItem(index, snapshot.data?.docs[index]),
            //     Text((listMessage[index] as Message).messageContent),
            itemBuilder: (context, index) {
              var messageDocRef = listMessage[index] as DocumentReference;
              return FutureBuilder<DocumentSnapshot>(
                future: messageDocRef.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var messageData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    var message = Message.fromJson(messageData);
                    return ChatBubbleWidget(
                      message: message,
                    );
                  }
                },
              );
            },

            itemCount: listMessage.length,
            reverse: true,
            controller: listScrollController,
          );
        }
      },
    );
  }

  // buildItem(int index, QueryDocumentSnapshot<Object?>? doc) {}
}
