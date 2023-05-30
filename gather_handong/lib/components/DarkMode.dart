import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gather_handong/main.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({Key? key}) : super(key: key);

  @override
  _DarkMode createState() => _DarkMode();
}

class _DarkMode extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();
    // TODO: implement build
    return ToggleSwitch(
      minWidth: 60.0,
      minHeight: 40.0,
      initialLabelIndex: appState.darkMode,
      cornerRadius: 20.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      totalSwitches: 2,
      icons: [
        FontAwesomeIcons.moon,
        FontAwesomeIcons.sun,
      ],
      iconSize: 30.0,
      activeBgColors: [
        [Colors.blue, Colors.black],
        [Colors.yellow, Colors.orange]
      ],
      animate:
          true, // with just animate set to true, default curve = Curves.easeIn
      curve: Curves
          .bounceInOut, // animate must be set to true when using custom curve
      onToggle: (index) {
        print('switched to: $index');
        appState.changeDarkMode(index!);
      },
    );
  }
}
