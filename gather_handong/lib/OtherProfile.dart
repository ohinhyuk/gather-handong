import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/components/ButtomNavBar.dart';
import 'package:gather_handong/components/DarkMode.dart';
import 'package:gather_handong/components/GridButtons.dart';
import 'package:gather_handong/controller/FirebaseController.dart';
import 'package:gather_handong/main.dart';
import 'package:gather_handong/model/myUser.dart';
import 'package:gather_handong/modify.dart';

import 'package:provider/provider.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class OtherProfile extends StatelessWidget {
  OtherProfile({Key? key, required this.user}) : super(key: key);

  final DocumentSnapshot<Object?> user;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    return Scaffold(
      floatingActionButton: DarkMode(),
      bottomNavigationBar: ButtomNavBar(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
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
          padding: EdgeInsets.only(left: 0, right: 0),
          child: ListView(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return ShadowOverlay(
                        shadowColor: Colors.black,
                        child: Image.network(
                          user['profileImages'][index],
                          fit: BoxFit.cover,
                          height: 300,
                          width: 400,
                        ),
                        shadowWidth: 400,
                        shadowHeight: 200,
                      );
                      //   Image.network(
                      //   snapshot.data!.get('profileImages')[index],
                      //   fit: BoxFit.fill,
                      // );
                    },
                    // scrollDirection: Axis.vertical,
                    itemCount: user['profileImages'].length,
                    itemWidth: 400,
                    itemHeight: 300.0,
                    layout: SwiperLayout.CUSTOM,
                    customLayoutOption:
                        CustomLayoutOption(startIndex: -1, stateCount: 3)
                          // ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                          ..addTranslate([
                            Offset(-440.0, -40.0),
                            Offset(0.0, 0.0),
                            Offset(440.0, -40.0)
                          ]),
                    // layout: SwiperLayout.TINDER,
                    pagination: SwiperPagination(),
                    // control: SwiperControl(),
                    viewportFraction: 0.8,
                    scale: 0.9,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                    user['nickname'] + user['age'].toString() + user['sex']),
              ),
              const Divider(thickness: 1, height: 1),
              const SizedBox(
                height: 15,
              ),
              const Text('내가 찾는 관계'),
              Card(
                child: Text(user['relation']),
              ),
              const Text('나의 관심사'),
              GridButtons(
                items: user['interest'],
              ),
              const Text('나의 소개'),
              GridButtons(
                items: user['aboutMe'],
              ),
              const Text('나의 라이프스타일'),
              GridButtons(
                items: user['lifeStyle'],
              ),
            ],
          )),
    );

    // TODO: implement build
  }
}
