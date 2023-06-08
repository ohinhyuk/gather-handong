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
import 'package:gather_handong/ChatPage.dart';
import 'package:gather_handong/modify.dart';
import 'package:gather_handong/profile.dart';
import 'package:gather_handong/signup.dart';
import 'package:gather_handong/theme/theme.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'login.dart';
import 'main.dart';

// TODO: Convert ShrineApp to stateful widget (104)
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    return MaterialApp(
      title: 'Shrine',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) =>
            appState.loggedIn ? const SignUpPage() : const LoginPage(),
        // TODO: Change to a Backdrop with a HomePage frontLayer (104)
        '/': (BuildContext context) => const HomePage(),
        '/signup': (BuildContext context) => const SignUpPage(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/chat': (BuildContext context) => const ChatPage(),
        // TODO: Make currentCategory field take _currentCategory (104)
        // TODO: Pass _currentCategory for frontLayer (104)
        // TODO: Change backLayer field value to CategoryMenuPage (104)
      },
      // TODO: Customize the theme (103)
      theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              appState.darkMode == 0 ? darkColorScheme : lightColorScheme,
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
          )),
      // apply dark mode theme
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
          )),
    );
  }
}

// TODO: Build a Shrine Theme (103)
// TODO: Build a Shrine Text Theme (103)
