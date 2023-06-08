import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/app.dart';
import 'package:gather_handong/components/ButtomNavBar.dart';
import 'package:gather_handong/controller/FirebaseController.dart';

import 'ChatPage.dart';

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
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text('좋아요 페이지'),
      ),
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
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final docs = snapshot.data!.docs;
                      print("!");

                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = docs[index];
                          return Material(
                            // Add this
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                  // onTap: () => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => ChatPage(
                                  //           selectedChatRoomId: doc['chatRoomId']),
                                  //     )),
                                  leading: const Icon(Icons.message),
                                  title: Text(
                                    doc['nickname'] + "님이 관심 ❤️을 표현하였습니다.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      FilledButton(
                                        child: Text('정보 보기'),
                                        onPressed: () => {},
                                      ),
                                      OutlinedButton(
                                          onPressed: () => {},
                                          child: Text('매칭 후 대화하기'))
                                    ],
                                  )),
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
