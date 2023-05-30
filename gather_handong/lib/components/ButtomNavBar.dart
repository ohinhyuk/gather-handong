import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/main.dart';
import 'package:provider/provider.dart';

class ButtomNavBar extends StatefulWidget {
  ButtomNavBar({Key? key}) : super(key: key);

  @override
  _ButtomNavBar createState() => _ButtomNavBar();
}

class _ButtomNavBar extends State<ButtomNavBar> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();
    // TODO: implement build
    return ConvexAppBar(
      initialActiveIndex: appState.initNum,
      items: [
        TabItem(icon: Icons.favorite, title: '매칭'),
        TabItem(icon: Icons.people, title: '그룹매칭'),
        TabItem(icon: Icons.chat_bubble, title: '채팅'),
        TabItem(icon: Icons.person, title: '프로필'),
      ],
      height: 50,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      // style: TabStyle.react,
      onTap: (int i) async => {
        appState.setInitNum(i),
        if (i == 0)
          {Navigator.pushNamed(context, '/')}
        else if (i == 3)
          {
            Navigator.pushNamed(context, '/profile'),
          },
      },
    );
  }
}
