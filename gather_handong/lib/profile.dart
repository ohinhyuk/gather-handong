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
import 'package:gather_handong/modify.dart';

import 'package:provider/provider.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  var name = "";
  var email = "";
  var photoUrl = "";
  var uid = "";
  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    // final user = FirebaseAuth.instance.currentUser;

    final user = FirebaseFirestore.instance
        .collection('myUsers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    // print(user!.isAnonymous);
    //
    // if (user != null) {
    //   if (user.isAnonymous == true) {
    //     // Name, email address, and profile photo URL
    //     photoUrl = 'https://handong.edu/site/handong/res/img/logo.png';
    //     uid = user.uid;
    //     email = 'Anonymous';
    //     name = 'Inhyuk Oh';
    //   } else {
    //     uid = user.uid;
    //     name = user.displayName ?? '';
    //     email = user.email ?? '';
    //     photoUrl = user.photoURL ?? '';
    //   }
    // }

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
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('myUsers')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Scaffold();
            return Padding(
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
                                snapshot.data!.get('profileImages')[index],
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
                          itemCount: snapshot.data!.get('profileImages').length,
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
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FloatingActionButton(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ModifyPage(
                                                user: snapshot!.data!)));
                                  },
                                  child: const Icon(Icons.edit),
                                ),
                              ],
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(snapshot.data!.get('nickname') +
                          snapshot.data!.get('age').toString() +
                          snapshot.data!.get('sex')),
                    ),
                    const Divider(thickness: 1, height: 1),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('내가 찾는 관계'),
                    Card(
                      child: Text(snapshot.data!.get('relation')),
                    ),
                    const Text('나의 관심사'),
                    GridButtons(
                      items: snapshot.data!.get('interest'),
                    ),
                    const Text('나의 소개'),
                    GridButtons(
                      items: snapshot.data!.get('aboutMe'),
                    ),
                    const Text('나의 라이프스타일'),
                    GridButtons(
                      items: snapshot.data!.get('lifeStyle'),
                    ),
                  ],
                ));
          },
        ));

    // TODO: implement build
  }
}
