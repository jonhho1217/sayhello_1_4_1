import 'package:flutter/material.dart';
import 'package:sayhello/utils/uidata.dart';

class MyAboutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationIcon: FlutterLogo(
        colors: Colors.yellow,
      ),
      icon: FlutterLogo(
        colors: Colors.yellow,
      ),
      aboutBoxChildren: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Proof of Concept",
        ),
        Text(
          "Jon Ho",
        ),
      ],
      applicationName: UIData.appName,
      applicationVersion: "1.0.1",
      applicationLegalese: "Apache License 2.0",
    );
  }
}
