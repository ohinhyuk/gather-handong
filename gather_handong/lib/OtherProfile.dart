import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/components/ButtomNavBar.dart';
import 'package:gather_handong/components/DarkMode.dart';
import 'package:gather_handong/components/GridButtons.dart';
import 'package:gather_handong/components/UserNameAgeSexBox.dart';
import 'package:gather_handong/main.dart';
import 'package:provider/provider.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class OtherProfile extends StatelessWidget {
  final DocumentSnapshot<Object?> user;

  OtherProfile({Key? key, required this.user}) : super(key: key);

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
                            user!['profileImages'][index],
                            fit: BoxFit.cover,
                            height: 300,
                            width: 400,
                          ),
                          shadowWidth: 400,
                          shadowHeight: 200,
                        );
                      },
                      itemCount: user!['profileImages'].length,
                      itemWidth: 400,
                      itemHeight: 300.0,
                      layout: SwiperLayout.CUSTOM,
                      customLayoutOption:
                          CustomLayoutOption(startIndex: -1, stateCount: 3)
                            ..addTranslate([
                              Offset(-440.0, -40.0),
                              Offset(0.0, 0.0),
                              Offset(440.0, -40.0)
                            ]),
                      pagination: SwiperPagination(),
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                    UserNameAgeSexBox(
                        nickname: user!['nickname'],
                        sex: user!['sex'],
                        age: user!['age'])
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                customTitle('내가 찾는 관계'),
                Wrap(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(user!['relation']),
                          ),
                        ))
                  ],
                ),
                customDivider(),
                customTitle('나의 관심사'),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GridButtons(
                    items: user!['interest'],
                  ),
                ),
                customDivider(),
                customTitle('나의 소개'),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: GridButtons(
                      items: user!['aboutMe'],
                    )),
                customDivider(),
                customTitle('나의 라이프스타일'),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GridButtons(
                    items: user!['lifeStyle'],
                  ),
                ),
              ],
            )));
  }
}

Widget customDivider() {
  return Column(
    children: [
      const SizedBox(
        height: 15,
      ),
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Divider(
          thickness: 2,
          height: 1,
          color: CupertinoColors.systemGrey2,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}

Widget customTitle(String text) {
  return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        text,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ));
}
