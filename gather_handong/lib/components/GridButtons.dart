import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridButtons extends StatelessWidget {
  final List<dynamic> items;

  GridButtons({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Wrap(
        spacing: 5,
        runSpacing: -15, // 버튼 간 라인 간격을 음수로 설정하여 줄입니다
        alignment: WrapAlignment.start, // 왼쪽으로 정렬합니다
        children: items.map((elem) {
          return OutlinedButton(
            onPressed: null,
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
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              side: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              minimumSize: Size(0, 0),
            ),
          );
        }).toList(),
      ),
    );
  }
}
