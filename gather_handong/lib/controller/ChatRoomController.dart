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

  static void chatroomAdd(ChatRoom chatRoom) => FirebaseFirestore.instance
      .collection('chatRoom')
      .doc(chatRoom.chatRoomId)
      .set(chatRoom.toJson());

  // static Future<QuerySnapshot> getChatRoomByUsers(String uid1, String uid2) {
  //   return FirebaseFirestore.instance
  //       .collection('chatRoom')
  //       .where('users', arrayContainsAny: [uid1, uid2]).get();
  // }
  // static Future<QuerySnapshot> getChatRoomByUsers(String uid1, String uid2) {
  //   return FirebaseFirestore.instance
  //       .collection('chatRoom')
  //       .where('users', arrayContains: uid1)
  //       .where('users', arrayContains: uid2)
  //       .get();
  // }
  static Future<QuerySnapshot> getChatRoomByUsers(String uid1, String uid2) {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .where('users', whereIn: [
      [uid1, uid2],
      [uid2, uid1]
    ]).get();
  }
}
