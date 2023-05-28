import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridButtonsSignup extends StatefulWidget {
  final List<dynamic> items;
  final List<dynamic> myItems;

  GridButtonsSignup({required this.items, required this.myItems});

  @override
  _GridButtonsSignup createState() => _GridButtonsSignup();
}

class _GridButtonsSignup extends State<GridButtonsSignup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Wrap(
        spacing: 5,
        runSpacing: -15, // 버튼 간 라인 간격을 음수로 설정하여 줄입니다
        alignment: WrapAlignment.start, // 왼쪽으로 정렬합니다
        children: widget.items.map((elem) {
          return Container(
            child: widget.myItems.contains(elem)
                ? FilledButton(
                    onPressed: () {
                      setState(() {
                        widget.myItems.remove(elem);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Text(
                        elem,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: Size(0, 0),
                    ),
                  )
                : OutlinedButton(
                    onPressed: () {
                      setState(() {
                        widget.myItems.add(elem);
                        print(widget.myItems);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Text(
                        elem,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: Size(0, 0),
                    ),
                  ),
          );
        }).toList(),
      ),
    );
  }
}
