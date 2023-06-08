import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gather_handong/model/myUser.dart';

class ChatRoom {
  String chatRoomId;
  List<String> users;
  List<Map<String, String>> messages;

  ChatRoom(
      {required this.chatRoomId, required this.users, required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatRoomId: json['chatRoomId'],
      users: List<String>.from(json['users']),
      messages: List<Map<String, String>>.from(json['messages']
          .map((messageMap) => Map<String, String>.from(messageMap ?? {}))),
    );
  }

  factory ChatRoom.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return ChatRoom(
      chatRoomId: snapshot['chatRoomId'],
      users: List<String>.from(snapshot['users']),
      messages: List<Map<String, String>>.from(snapshot['messages']
          .map((messageMap) => Map<String, String>.from(messageMap ?? {}))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'users': users,
      'messages':
          messages.map((message) => Map<String, dynamic>.from(message)).toList()
    };
  }
}
