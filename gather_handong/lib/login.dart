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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/controller/FirebaseController.dart';
import 'package:gather_handong/main.dart';
import 'package:gather_handong/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
// import 'package:shrine/model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_gather_handong.png',
                  // width: 200,
                  width: 200,
                  scale: 0.7, // 이미지의 너비를 설정합니다.
                  height: 130,
                ),
                const SizedBox(height: 20.0),
                Text(
                  '모여라 한동',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 80.0),
            // TODO: Remove filled: true values (103)
            Center(
              child: Text(
                '고린도전서 16:14',
              ),
            ),
            Center(
              child: Text('너희 모든 일을 사랑으로 행하라'),
            ),
            const SizedBox(height: 50.0),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                // TODO: Add a beveled rectangular border to CANCEL (103)

                // TODO: Add an elevation to NEXT (103)
                // TODO: Add a beveled rectangular border to NEXT (103)
                Container(
                  child: ElevatedButton(
                    child: const Text('Google'),
                    onPressed: () async => {
                      await signInWithGoogle(),
                      FirebaseController.userAdd(UserDB(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          email: FirebaseAuth.instance.currentUser!.email
                              as String,
                          name: FirebaseAuth.instance.currentUser!.displayName
                              as String,
                          status_message:
                              'I promise to take the test honestly before GOD .')),
                      appState.changeLoggedIn(true),
                    },
                  ),
                  width: 400,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
