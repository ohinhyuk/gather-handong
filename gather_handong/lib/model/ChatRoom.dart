import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gather_handong/model/Message.dart';
import 'package:gather_handong/model/myUser.dart';

class ChatRoom {
  String chatRoomId;
  // myUser connector;
  // myUser contact;
  List<String> users;
  List<Message> messages;

  ChatRoom(
      {required this.chatRoomId, required this.users, required this.messages});

  factory ChatRoom.fromJson(Map<dynamic, dynamic> json) {
    return ChatRoom(
        chatRoomId: json['chatRoomId'],
        users: json['users'],
        messages: json['messages']
            .map((message) => Message.fromJson(message))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'users': users,
      'messages': messages.map((message) => message.toJson()).toList()
    };
  }

  factory ChatRoom.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final List<Message> message = [];
    final messageSnapshot = List<Map>.from(snapshot['messages'] as List);
    for (var e in messageSnapshot) {
      message.add(Message.fromJson(e as Map<String, dynamic>));
    }
    return ChatRoom(
        chatRoomId: snapshot['chatRoomId'],
        // connector:
        //     myUser.fromJson(snapshot['connector' as Map<String, dynamic>]),
        // contact: myUser.fromJson(snapshot['contact'] as Map<String, dynamic>),
        users: snapshot['users'],
        messages: message);
  }
}
