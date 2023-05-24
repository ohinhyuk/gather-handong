import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class myUser {
  String? uid;
  late String email;
  late String nickname;
  late int age;
  late String sex;
  late String location;
  late List<dynamic> aboutMe;
  late List<dynamic> interest;
  late List<dynamic> lifeStyle;
  late List<dynamic> profileImages;
  // late List<dynamic> aboutYou;
  late String relation;
  late List<dynamic> likes;

  // Timestamp? _createTime;
  // Timestamp? _updateTime;
  // late boolean isOnline;

  // late String email;
  // late String status_message;

  // late String uid;
  // late Timestamp createTime;
  // late Timestamp updateTime;

  myUser({
    this.uid,
    required this.email,
    required this.nickname,
    required this.age,
    required this.sex,
    required this.location,
    required this.aboutMe,
    required this.interest,
    required this.lifeStyle,
    required this.profileImages,
    // required this.aboutYou,
    required this.relation,
    required this.likes,
  });

  myUser.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    email = json['email'];
    age = json['age'];
    sex = json['sex'];
    location = json['location'];
    aboutMe = json['aboutMe'];
    interest = json['interest'];
    lifeStyle = json['lifeStyle'];
    profileImages = json['profileImages'];
    // aboutYou = json['aboutYou'];
    relation = json['relation'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() => {
    // id 부분 유심히 보기
    'uid' : uid,
    'nickname' : nickname,
    'email' : email,
    'age' : age,
    'sex' : sex,
    'location' : location,
    'aboutMe' : aboutMe,
    'interest' : interest,
    'lifeStyle' : lifeStyle,
    'profileImages' : profileImages,
    // 'aboutYou' : aboutYou,
    'relation' : relation,
    'likes' : likes

  };
}
