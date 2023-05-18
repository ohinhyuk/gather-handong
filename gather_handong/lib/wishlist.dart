import 'package:flutter/material.dart';
import 'package:gather_handong/main.dart';

import 'package:provider/provider.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  _WishListPage createState() => _WishListPage();
}

class _WishListPage extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Wish List'),
      ),
      body: ListView(
        // children: <Widget>[

        //     ...appState.cart.asMap().entries.map( (item, index) => {
        //         ListTile(
        //         leading: Image.network(item.imageUrl),
        //         title: item.name,
        //         trailing: IconButton(
        //         icon: Icon(Icons.delete),
        //         onPressed: (index) => {
        //         appState.deleteCart(index);
        //         },
        //         ),
        //   }
        // )).toList()
        children: <Widget>[
          ...appState.cart.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return ListTile(
              leading: Image.network(item.imageUrl),
              title: Text(item.name), // 수정된 부분
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  appState.deleteCart(index);
                },
              ),
            );
          }).toList(),
        ],

        // ],
      ),
    );
  }
}
