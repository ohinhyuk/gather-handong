import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridButtons extends StatelessWidget {
  final List<dynamic> items;

  GridButtons({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(0),
      mainAxisSpacing: 5,
      crossAxisSpacing: 10,
      // childAspectRatio: 4 / 2,
      crossAxisCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: items.map((elem) {
        return Card(
          // onPressed: null,
          child: Text(elem),
          // style: OutlinedButton.styleFrom(
          //   padding: EdgeInsets.only(
          //     right: 0,
          //   ),
          // ),
        );
      }).toList(),
    );
  }
}
