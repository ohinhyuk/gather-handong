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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/add.dart';
import 'package:gather_handong/controller/FirebaseController.dart';
import 'package:gather_handong/detail.dart';
import 'package:gather_handong/main.dart';
import 'package:gather_handong/model/myUser.dart';
import 'package:gather_handong/profile.dart';
import 'package:gather_handong/wishlist.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context, List<myUser> myUsers) {
    // var appState = context.watch<ApplicationState>();

    if (myUsers.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return myUsers.map((user) {
      return Card(
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
                              icon: Icon(Icons.favorite),
                              onPressed: () => {
                                    user.likes.remove(
                                        FirebaseAuth.instance.currentUser!.uid),
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
                              user.likes
                                  .add(FirebaseAuth.instance.currentUser!.uid),
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
                          Row(
                            children: [
                              ClipRRect(
                                // borderRadius: BorderRadius.circular(50.0),
                                child: Image.network(
                                  user.profileImages[0],
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      user.nickname,
                                      style: theme.textTheme.titleMedium,
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      user.age.toString(),
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // TODO: Handle overflowing labels (103)

                          //descrition
                          GridView.count(
                              padding: EdgeInsets.all(0),
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 10,
                              childAspectRatio: 4 / 2,
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: user.interest.map((elem) {
                                return FilledButton(
                                  onPressed: null,
                                  child: Text(elem),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.only(
                                      right: 0,
                                    ),
                                  ),
                                );
                              }).toList()),
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
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: TextButton(
                      onPressed: () => {},
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             DetailPage(user)
                      //
                      //     )),
                      child: const Text('more'))),
            ],
          ));
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
        onTap: (int i) => print('cliked'),
      ),

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.person,
            semanticLabel: 'profile',
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        title: const Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              semanticLabel: 'wishlist',
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WishListPage()));
            },
          ),
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
        const DropdownButtonExample(),
        Expanded(
            child: GridView.count(
                crossAxisCount: 1,
                padding: const EdgeInsets.all(20.0),
                childAspectRatio: 3 / 2,
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
