import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/components/ButtomNavBar.dart';

import 'ChatPage.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatList createState() => _ChatList();
}

class _ChatList extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;

    Future<QuerySnapshot> future = FirebaseFirestore.instance
        .collection('chatRoom')
        .where("users", arrayContains: myUid)
        .get();

    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: ButtomNavBar(),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          title: Text('채팅 리스트'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: future,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            // 가져온 데이터를 역순으로 정렬합니다.
            final reversedDocs = snapshot.data?.docs.reversed.toList();

            return ListView.builder(
              itemCount: reversedDocs?.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = reversedDocs![index];
                return Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2.0,
                        color: Theme.of(context)
                            .colorScheme
                            .background, // Change this color to the color you want
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatPage(selectedChatRoomId: doc['chatRoomId']),
                        )),
                    leading: const Icon(Icons.message),
                    trailing: Icon(
                      Icons.circle,
                      color: Colors.greenAccent,
                      size: 10,
                    ),
                    title: Text(
                      doc['users'][0] == myUid
                          ? doc['users'][1] + " 님"
                          : doc['users'][0] + " 님",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    subtitle: Text(
                      doc['messages'].length != 0
                          ? doc['messages'][doc['messages'].length - 1]
                              ['content']
                          : "메세지 없음",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
