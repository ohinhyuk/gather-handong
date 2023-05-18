import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/main.dart';

import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  var name = "";
  var email = "";
  var photoUrl = "";
  var uid = "";

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    final user = FirebaseAuth.instance.currentUser;

    print(user!.isAnonymous);

    if (user!.isAnonymous == true) {
      // Name, email address, and profile photo URL
      photoUrl = 'https://handong.edu/site/handong/res/img/logo.png';
      uid = user.uid;
      email = 'Anonymous';
      name = 'Inhyuk Oh';
    } else {
      uid = user.uid;
      name = user.displayName!;
      email = user.email!;
      photoUrl = user.photoURL!;
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
                onPressed: () async => {
                      // await Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginPage())),
                      appState.changeLoggedIn(false),
                      await Navigator.pushNamed(context, '/login'),
                      FirebaseAuth.instance.signOut(),
                    },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 70, right: 70),
            child: Column(
              children: [
                Image.network(photoUrl),
                const SizedBox(
                  height: 20,
                ),
                Text(uid),
                const Divider(thickness: 1, height: 1),
                Text(email),
                const SizedBox(
                  height: 15,
                ),
                Text(name),
                const Text('I promise to take the test honestly before GOD'),
              ],
            )));

    // TODO: implement build
  }
}
