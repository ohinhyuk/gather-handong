import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDB {
  String? uid;
  late String name;
  late String email;
  late String status_message;
  // late String uid;
  // late Timestamp createTime;
  // late Timestamp updateTime;

  UserDB({
    this.uid,
    required this.name,
    required this.email,
    required this.status_message,
    // required this.imageUrl,
    // required this.likeUsers,
    // required this.uid,
    // required this.createTime,
    // required this.updateTime,
  });

  UserDB.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    // List<String> likeUsers = <String>[];
    // likeUsers = json['likeUsers'];
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    status_message = json['status_message'];
  }

  Map<String, dynamic> toJson() => {
        // id 부분 유심히 보기
        'uid': uid,
        'name': name,
        'email': email,
        'status_message': status_message,
      };
}
