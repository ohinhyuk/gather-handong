import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gather_handong/model/ChatRoom.dart';

final myUid = FirebaseAuth.instance.currentUser!.uid;

class ChatRoomController {
  static get chatroomsSnapshots => FirebaseFirestore.instance
      .collection('chatRoom')
      .where("users", arrayContains: myUid)
      .snapshots();

  static get getChatRoom => (String chatroomId) {
        return FirebaseFirestore.instance
            .collection('chatRoom')
            .doc(chatroomId);
      };

  static Stream<QuerySnapshot<Object?>> chatroomSnapshot(String chatroomId) {
    return FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  static void chatroomUpdate(ChatRoom chatRoom) => FirebaseFirestore.instance
      .collection('chatRoom')
      .doc(chatRoom.chatRoomId)
      .set(chatRoom.toJson());
}
