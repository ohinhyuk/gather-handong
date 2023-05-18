import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:gather_handong/controller/FirebaseController.dart';
import 'package:gather_handong/main.dart';
import 'package:gather_handong/model/product.dart';
import 'package:gather_handong/modify.dart';

import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  // const DetailPage({Key? key}) : super(key: key);

  const DetailPage(this.product, {Key? key}) : super(key: key);

  final Product product;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();

    int _likes = widget.product.likeUsers.length;
    bool _isPresent = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detail'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.create,
              semanticLabel: 'modify',
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModifyPage(widget.product)));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              semanticLabel: 'delete',
            ),
            onPressed: () {
              FirebaseController.delete(widget.product.id!);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.network(widget.product.imageUrl),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.product.name),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up),
                          onPressed: () => {
                            // print(product.likeUsers[0]+  user?.uid),

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            if (widget.product.likeUsers.contains(user?.uid))
                              {
                                //

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      const Text('You can only do it once !!'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                ))
                              }
                            else
                              {
                                widget.product.likeUsers.add(user?.uid),
                                FirebaseController.update(widget.product),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text('I Like IT !'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                )),
                                //+1
                                setState(() {}),
                              }
                          },
                        ),
                        Text(_likes.toString()),
                      ],
                    )
                  ],
                ),
                Text('\$ ${widget.product.price}'),
                const Divider(
                  thickness: 1,
                  height: 1,
                ),
                SizedBox(height: 30),
                Text(widget.product.description),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: appState.checkIsProduct(widget.product)
          ? FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.check),
            )
          : FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
                appState.addCart(widget.product);
                print(appState.cart);
                print(widget.product.id);
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.shopping_cart),
            ),
    );
  }
}
