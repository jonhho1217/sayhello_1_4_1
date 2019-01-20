import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sayhello/container/container.dart';
import 'package:sayhello/constants.dart';
import 'package:sayhello/screens/login_page.dart';
import 'package:sayhello/screens/register_page.dart';
import 'package:sayhello/screens/idea_attr_page.dart';
import 'package:sayhello/screens/home_page.dart';
import 'package:sayhello/screens/notfound_page.dart';
import 'package:sayhello/themes.dart';
import 'package:sayhello/utils/uidata.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'SayHello',
    options: const FirebaseOptions(
      googleAppID: '1:1078068933478:android:668ae3e8dfce9ad5',
      apiKey: 'AIzaSyC0ALz3dlDvlHw5WJACMRSc9g-H0D7e5Oc',
      projectID: 'sayhello-bed85',
    ),
  );
  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  runApp(new StateContainer(child: new SayHelloApp(firestore: firestore)));
}

class SayHelloApp extends StatelessWidget {

  SayHelloApp({this.firestore});
  final Firestore firestore;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: Constants.APP_NAME,
        theme: Themes.getTheme(context),
        home: new LoginPage(),
        routes: <String, WidgetBuilder>{
          RegisterPage.routeName: (BuildContext context) =>
              const RegisterPage(),
            UIData.homeRoute: (BuildContext context) => HomePage(),
            UIData.myIdeaAttributeRoute: (BuildContext context) => IdeasAttributePage(),
          },
          onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
              builder: (context) => new NotFoundPage(
                appTitle: UIData.coming_soon,
                title: "Under Development",
                message: "This page is under",
                iconColor: Colors.green,
              )));
  }
}
