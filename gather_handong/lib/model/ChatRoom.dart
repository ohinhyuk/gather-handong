import 'dart:html';

import 'package:gather_handong/model/myUser.dart';

class ChatRoom{
  String chatRoomId;
  myUser connector;
  myUser contact;
  List<Message> messages;

  ChatRoom({required this.chatRoomId,
  required this.connector,
  required this.contact,
  required this.messages})

  factory ChatRoom.fromJson(Map<dynamic,dynamic> json){
    return ChatRoom(
      chatRoomId: json['chatRoomId'],
      connector: json['connector'].map((connector) => myUser.fromJson(connector)),
      contact: json['contact'].map((contact) => myUser.fromJson(contact)),
      messages: json['messages'].map((message) => Message.fromJson(message)).toList()
    );
  }

  Map<String ,dynamic> toJson(){
    return{
    'chatRoomId' : chatRoomId,
        'connector': connector.toJson(),
    'contact': contact.toJson(),
    'messages' : messages.map((message) => message.toJson()).toList()
  };
  }

  factory ChatRoom.fromDocumentSnapshot(DocumentSnapshot snapshot){
    final List<Message> message = [];
    final messageSnapshot = List<Map>.from(snapshot['messages'] as List);
    for( var e in messageSnapshot){
      message.add(Message.fromJson(e as Map<String , dynamic>));
    }
    return ChatRoom(chatRoomId: snapshot['chatRoomId'],
        connector: myUser.fromJson(snapshot['connector' as Map<String, dynamic>]),
        contact: myUser.fromJson(snapshot['contact'] as Map<String,dynamic>),
        messages: message);
  }
}