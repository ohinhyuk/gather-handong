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

import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gather_handong/add.dart';
import 'package:gather_handong/components/GridButtons.dart';
import 'package:gather_handong/controller/FirebaseController.dart';
import 'package:gather_handong/detail.dart';
import 'package:gather_handong/main.dart';
import 'package:gather_handong/model/myUser.dart';
import 'package:gather_handong/profile.dart';
import 'package:gather_handong/wishlist.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Widget> _buildGridCards(BuildContext context, List<myUser> myUsers) {
    // var appState = context.watch<ApplicationState>();

    if (myUsers.isEmpty) {
      return const <Widget>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return myUsers.map((user) {
      return FlashCard(
          width: 400,
          height: 800,
          frontWidget: Card(
              clipBehavior: Clip.antiAlias,
              // TODO: Adjust card heights (103)
              child: Stack(
                children: [
                  // appState.checkIsProduct(user)
                  user.likes.contains(FirebaseAuth.instance.currentUser?.uid)
                      ? Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: theme.colorScheme.primary,
                                  ),
                                  onPressed: () => {
                                        user.likes.remove(FirebaseAuth
                                            .instance.currentUser!.uid),
                                        FirebaseController.myUserUpdate(user),
                                      }),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite_border_outlined),
                                onPressed: () => {
                                  user.likes.add(
                                      FirebaseAuth.instance.currentUser!.uid),
                                  FirebaseController.myUserUpdate(user),
                                },
                              ),
                            ],
                          ),
                        ),
                  Column(
                    // TODO: Center items on the card (103)
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            // TODO: Align labels to the bottom and center (103)
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // TODO: Change innermost Column (103)
                            children: <Widget>[
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 16,
                                        top: 10,
                                        bottom: 20),
                                    child: Row(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.nickname +
                                              ", " +
                                              user.age.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w700),
                                          maxLines: 1,
                                        ),
                                        // Text(
                                        //   user.age.toString(),
                                        //   style: theme.textTheme.titleLarge,
                                        // ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        user.sex == '남자'
                                            ?
                                            // Text('')
                                            Text(
                                                '男',
                                                style: TextStyle(
                                                  color: Colors.blue[600],
                                                  fontSize: 20,
                                                ),
                                              )
                                            // Icon(
                                            //     Icons.man,
                                            //     // color: Colors.grey[600],
                                            //     // color: Colors.blue,
                                            //   )
                                            : Text(
                                                '女',
                                                style: TextStyle(
                                                  color: Colors.pinkAccent,
                                                  fontSize: 20,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    // borderRadius: BorderRadius.circular(50.0),
                                    child: Swiper(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Image.network(
                                          user.profileImages[index],
                                          fit: BoxFit.fill,
                                        );
                                      },
                                      // scrollDirection: Axis.vertical,
                                      itemCount: user.profileImages.length,
                                      itemWidth: 250.0,
                                      itemHeight: 250.0,
                                      layout: SwiperLayout.CUSTOM,
                                      customLayoutOption: CustomLayoutOption(
                                          startIndex: -1, stateCount: 3)
                                        // ..addRotate(
                                        //     [-45.0 / 180, 0.0, 45.0 / 180])
                                        ..addTranslate([
                                          Offset(-370.0, -40.0),
                                          Offset(0.0, 0.0),
                                          Offset(370.0, -40.0)
                                        ]),
                                      // layout: SwiperLayout.TINDER,
                                      pagination: SwiperPagination(),
                                      // control: SwiperControl(),
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: GridButtons(items: user.interest),
                                  ),
                                ],
                              ),
                              // TODO: Handle overflowing labels (103)

                              //descrition

                              // Text(
                              // user.location,
                              // style: theme.textTheme.titleMedium,
                              // maxLines: 2,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          backWidget: Card(
              clipBehavior: Clip.antiAlias,
              // TODO: Adjust card heights (103)
              child: Stack(
                children: [
                  // appState.checkIsProduct(user)
                  user.likes.contains(FirebaseAuth.instance.currentUser?.uid)
                      ? Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: theme.colorScheme.primary,
                                  ),
                                  onPressed: () => {
                                        user.likes.remove(FirebaseAuth
                                            .instance.currentUser!.uid),
                                        FirebaseController.myUserUpdate(user),
                                      }),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite_border_outlined),
                                onPressed: () => {
                                  user.likes.add(
                                      FirebaseAuth.instance.currentUser!.uid),
                                  FirebaseController.myUserUpdate(user),
                                },
                              ),
                            ],
                          ),
                        ),
                  Column(
                    // TODO: Center items on the card (103)
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            // TODO: Align labels to the bottom and center (103)
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // TODO: Change innermost Column (103)
                            children: <Widget>[
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 16,
                                        top: 10,
                                        bottom: 20),
                                    child: Row(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.nickname +
                                              ", " +
                                              user.age.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w700),
                                          maxLines: 1,
                                        ),
                                        // Text(
                                        //   user.age.toString(),
                                        //   style: theme.textTheme.titleLarge,
                                        // ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        user.sex == '남자'
                                            ?
                                            // Text('')
                                            Text(
                                                '男',
                                                style: TextStyle(
                                                  color: Colors.blue[600],
                                                  fontSize: 20,
                                                ),
                                              )
                                            // Icon(
                                            //     Icons.man,
                                            //     // color: Colors.grey[600],
                                            //     // color: Colors.blue,
                                            //   )
                                            : Text(
                                                '女',
                                                style: TextStyle(
                                                  color: Colors.pinkAccent,
                                                  fontSize: 20,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),

                                  // 이제 나머지 내용 여기 다 넣어야함.
                                  // 이렇게 해서 카드를 꾸미고 이걸 프로필에서도 사용할 예정
                                  // Text('내가 찾는 관계'),
                                  Center(
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: SizedBox(
                                        width: 270,
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                          user.relation,
                                          style: TextStyle(
                                              color: theme.colorScheme.primary),
                                        )),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        bottom: 10,
                                        left: 10,
                                        right: 10),
                                    child: Divider(
                                        height: 1.0,
                                        color: theme.colorScheme.secondary),
                                  ),

                                  GridButtons(items: user.aboutMe),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10),
                                    child: Divider(
                                        height: 1.0,
                                        color: theme.colorScheme.secondary),
                                  ),

                                  GridButtons(items: user.lifeStyle),
                                ],
                              ),
                              // TODO: Handle overflowing labels (103)

                              // //descrition
                              // GridView.count(
                              //     padding: EdgeInsets.all(0),
                              //     mainAxisSpacing: 5,
                              //     crossAxisSpacing: 10,
                              //     childAspectRatio: 4 / 2,
                              //     crossAxisCount: 4,
                              //     shrinkWrap: true,
                              //     physics: NeverScrollableScrollPhysics(),
                              //     children: user.interest.map((elem) {
                              //       return FilledButton(
                              //         onPressed: null,
                              //         child: Text(elem),
                              //         style: OutlinedButton.styleFrom(
                              //           padding: EdgeInsets.only(
                              //             right: 0,
                              //           ),
                              //         ),
                              //       );
                              //     }).toList()),

                              // Text(
                              // user.location,
                              // style: theme.textTheme.titleMedium,
                              // maxLines: 2,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Positioned(
                  //     bottom: 0,
                  //     right: 0,
                  //     child: TextButton(
                  //         onPressed: () => {},
                  //         // Navigator.push(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //         builder: (context) =>
                  //         //             DetailPage(user)
                  //         //
                  //         //     )),
                  //         child: const Text('more'))),
                ],
              )));
    }).toList();
  }

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    /// static accessors
    // void collection() => FirebaseFirestore.instance.collection('products');
    // void ordered() => collection.orderBy('price', descending: appState.sorting =='ASC' ? false : true);
    // void  get() => ordered.get();
    snapshots() => FirebaseFirestore.instance
        .collection('myUsers')
        .orderBy('nickname',
            descending: appState.sorting == 'ASC' ? false : true)
        .snapshots();

    /// static methods
    // firebase query methods (add, update & delete)
    // static void add(Product product) => collection.add(product.toJson());
    // static void update(Product product) => collection.doc(product.id).set(product.toJson());
    // static void delete(String id) => collection.doc(id).delete();

    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => ModifyPage(product)),
          // );
        },
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: ToggleSwitch(
          minWidth: 90.0,
          minHeight: 70.0,
          initialLabelIndex: 0,
          cornerRadius: 20.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          icons: [
            FontAwesomeIcons.lightbulb,
            FontAwesomeIcons.solidLightbulb,
          ],
          iconSize: 30.0,
          activeBgColors: [
            [Colors.black45, Colors.black26],
            [Colors.yellow, Colors.orange]
          ],
          animate:
              true, // with just animate set to true, default curve = Curves.easeIn
          curve: Curves
              .bounceInOut, // animate must be set to true when using custom curve
          onToggle: (index) {
            print('switched to: $index');
          },
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.favorite, title: '매칭'),
            TabItem(icon: Icons.people, title: '그룹매칭'),
            TabItem(icon: Icons.chat_bubble, title: '채팅'),
            TabItem(icon: Icons.person, title: '프로필'),
          ],
          height: 50,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          // style: TabStyle.react,
          onTap: (int i) => {
                if (i == 3) {Navigator.pushNamed(context, '/profile')}
              }),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        // leading:
        // IconButton(
        //   icon: const Icon(
        //     Icons.person,
        //     semanticLabel: 'profile',
        //   ),
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => ProfilePage()));
        //   },
        // ),
        title: Text(
          '모여라 한동',
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              semanticLabel: 'add',
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddPage()));
            },
          ),
        ],
      ),
      // body: GridView.count(
      //   crossAxisCount: 2,
      //   padding: const EdgeInsets.all(16.0),
      //   childAspectRatio: 8.0 / 9.0,
      //   children: _buildGridCards(context),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: snapshots(),
        builder: _builder,
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    print(snapshot.data);
    if (snapshot.data == null) return const Scaffold();

    List<myUser> myUsers = snapshot.data?.docs.map<myUser>((data) {
          myUser user = myUser.fromJson(data.data() as Map<String, dynamic>);
          user.uid = user.uid;
          return user;
        }).toList() ??
        [];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15, bottom: 5),
          child: Center(
              child: Text(
            '더 알아가보고 싶은 분께 관심을 표현해주세요!',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          )),
        ),
        // Divider(thickness: 2, color: Theme.of(context).colorScheme.secondary),
        // const DropdownButtonExample(),
        Expanded(
            child: GridView.count(
                crossAxisCount: 1,
                padding: const EdgeInsets.all(20.0),
                childAspectRatio: 3 / 4,
                children: _buildGridCards(context, myUsers)))
      ],
    );
  }
}

const List<String> list = <String>['ASC', 'DESC'];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({Key? key}) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    return DropdownButton<String>(
      value: appState.sorting,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        appState.changeSorting(value);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
