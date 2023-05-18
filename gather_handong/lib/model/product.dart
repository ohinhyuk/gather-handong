// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// enum Category {
//   all,
//   accessories,
//   clothing,
//   home,
// }
//
// class Product {
//   const Product({
//     required this.category,
//     required this.id,
//     required this.isFeatured,
//     required this.name,
//     required this.price,
//   });
//
//   final Category category;
//   final int id;
//   final bool isFeatured;
//   final String name;
//   final int price;
//
//   String get assetName => '$id-0.jpg';
//   String get assetPackage => 'shrine_images';
//
//   @override
//   String toString() => "$name (id=$id)";
// }



import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  String? id;
  late String name;
  late int price;
  late String imageUrl;
  late String description;
  late List<dynamic> likeUsers;
  // late String uid;
  // late Timestamp createTime;
  // late Timestamp updateTime;


  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.likeUsers,
    // required this.uid,
    // required this.createTime,
    // required this.updateTime,
});

  Product.fromJson(Map<String, dynamic> json){
    fromJson(json);
  }

  void fromJson(Map<String,dynamic> json){
      // List<String> likeUsers = <String>[];
      // likeUsers = json['likeUsers'];

      id = json['id'];
      name = json['name'];
      price = json['price'];
      imageUrl = json['imageUrl'];
      description = json['description'];
      likeUsers = json['likeUsers'];
      // uid = json['uid'];
      // createTime = json['createTime'];
      // updateTime = json['updateTime'];

  }

  Map<String , dynamic> toJson() => {
    // id 부분 유심히 보기
    'id' : id,
    // 'id' : id,
    'name' : name,
    'price' : price,
    'imageUrl' : imageUrl,
    'description' : description,
    'likeUsers' : likeUsers,
    // 'uid' : uid,
    // 'createTime' : createTime,
    // 'updateTime' : updateTime,
  };


}