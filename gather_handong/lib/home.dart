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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/add.dart';
import 'package:gather_handong/detail.dart';
import 'package:gather_handong/main.dart';
import 'package:gather_handong/profile.dart';
import 'package:gather_handong/wishlist.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context, List<Product> products) {
    // List<Product> products =
    var appState = context.watch<ApplicationState>();

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          clipBehavior: Clip.antiAlias,
          // TODO: Adjust card heights (103)
          child: Stack(
            children: [
              appState.checkIsProduct(product)
                  ? Padding(padding: EdgeInsets.all(16) , child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.favorite_border_outlined),
                      ],
                    )
                ,) : Row(),
              Column(
                // TODO: Center items on the card (103)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        // TODO: Align labels to the bottom and center (103)
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // TODO: Change innermost Column (103)
                        children: <Widget>[
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              
Padding(padding: EdgeInsets.only(left: 16, right: 16) , child:  Column(

  children: [
    Text(
      product.name,
      style: theme.textTheme.titleMedium,
      maxLines: 1,
    ),

    Text(
      formatter.format(product.price),
      style: theme.textTheme.titleSmall,
    ),

  ],

)
  ,)

                            ],
                          ),
                          // TODO: Handle overflowing labels (103)



                        //descrition
                          Text(
                            product.description,
                            style: theme.textTheme.titleMedium,
                            maxLines: 2,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailPage(product))),
                                  child: const Text('more'))
                            ],
                          ),

                        ],


                      ),
                    ),
                  ),



                ],


              ),

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
        .collection('products')
        .orderBy('price', descending: appState.sorting == 'ASC' ? false : true)
        .snapshots();

    /// static methods
    // firebase query methods (add, update & delete)
    // static void add(Product product) => collection.add(product.toJson());
    // static void update(Product product) => collection.doc(product.id).set(product.toJson());
    // static void delete(String id) => collection.doc(id).delete();

    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
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

    List<Product> products = snapshot.data?.docs.map<Product>((data) {
          Product product =
              Product.fromJson(data.data() as Map<String, dynamic>);
          product.id = product.id;
          return product;
        }).toList() ??
        [];
    return Column(
      children: [
        const DropdownButtonExample(),
        Expanded(
            child: GridView.count(
                crossAxisCount: 1,
                padding: const EdgeInsets.all(20.0),
                childAspectRatio: 10.0 / 7.1,
                children: _buildGridCards(context, products)))
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
