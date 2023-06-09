import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/OtherProfile.dart';
import 'package:gather_handong/app.dart';
import 'package:gather_handong/components/ButtomNavBar.dart';
import 'package:gather_handong/components/generateUniqueKey.dart';
import 'package:gather_handong/controller/ChatRoomController.dart';
import 'package:gather_handong/controller/FirebaseController.dart';

import 'ChatPage.dart';
import 'model/ChatRoom.dart';

class LikePage extends StatefulWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  _LikePage createState() => _LikePage();
}

class _LikePage extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          '좋아요 페이지',
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      bottomNavigationBar: ButtomNavBar(),
      body: FutureBuilder<DocumentSnapshot>(
          future: myProfileSnapshots,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<dynamic> likes = snapshot.data!.get('likes') ?? [];
              if (likes.length == 0) {
                return Material(
                    // Add this
                    color: Colors.transparent,
                    child: Center(
                      child: Text('no one Liked yet.'),
                    ));
              }
              // List<String>.from(snapshot.data!['likes'] ?? []);
              return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('myUsers')
                      .where('uid', whereIn: likes)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (!snapshot.hasData) {
                      return ListView(
                        children: [
                          Material(
                              // Add this
                              color: Colors.transparent,
                              child: Center(
                                child: Text('no one Liked yet.'),
                              ))
                        ],
                      );
                    } else {
                      final docs = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = docs[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 0, left: 5, right: 5),
                            child: Material(
                              // Add this
                              color: Colors.transparent,
                              child: Card(
                                // padding: EdgeInsets.only(top: 5, bottom: 5),
                                // decoration: BoxDecoration(
                                //   border: Border(
                                //     bottom: BorderSide(
                                //         width: 2.0, color: Colors.grey),
                                //   ),
                                // ),
                                child: ListTile(

                                    // onTap: () => Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => ChatPage(
                                    //           selectedChatRoomId: doc['chatRoomId']),
                                    //     )),
                                    leading: const Icon(Icons.person),
                                    title: Text(
                                      doc['nickname'] + "님이 관심 ❤️을 표현하였습니다.",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                    ),
                                    subtitle: Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                            child: Text('정보 보기'),
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtherProfile(user: doc),
                                                )),
                                          ),
                                          SizedBox(width: 10),
                                          FilledButton(
                                              onPressed:
                                                  () => showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                              '정말 매칭하시겠습니까?'),
                                                          content: const Text(
                                                              '매칭 후에는 채팅이 가능합니다!'),
                                                          actions: <Widget>[
                                                            OutlinedButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context,
                                                                      'Cancel'),
                                                              child: const Text(
                                                                  '아니요'),
                                                            ),
                                                            FilledButton(
                                                              onPressed: () => ChatRoomController.getChatRoomByUsers(
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid,
                                                                      doc[
                                                                          'uid'])
                                                                  .then((QuerySnapshot
                                                                      snapshot) async {
                                                                if (snapshot
                                                                    .docs
                                                                    .isNotEmpty) {
                                                                } else {
                                                                  String? nickname = await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'myUsers')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .get()
                                                                      .then((snapshot) =>
                                                                          snapshot.data()?['nickname']
                                                                              as String?);

                                                                  ChatRoomController.chatroomAdd(ChatRoom(
                                                                      chatRoomId:
                                                                          generateUniqueKey(),
                                                                      users: [
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid,
                                                                        doc['uid'],
                                                                      ],
                                                                      messages: [],
                                                                      userNames: [
                                                                        nickname!,
                                                                        doc['nickname']
                                                                      ]));
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          const Text(
                                                                              '채팅방이 생성되었습니다!'),
                                                                      action:
                                                                          SnackBarAction(
                                                                        label:
                                                                            '닫기',
                                                                        onPressed:
                                                                            () {
                                                                          // Some code to undo the change.
                                                                        },
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              }).catchError(
                                                                      (error) {
                                                                // 오류 처리를 위한 코드 작성
                                                              }),
                                                              child: const Text(
                                                                  '예'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              child: Text('매칭 후 대화하기'))
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  });
            }
          }),
    );
  }

  Future<DocumentSnapshot> get myProfileSnapshots => FirebaseFirestore.instance
      .collection('myUsers')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();
}
