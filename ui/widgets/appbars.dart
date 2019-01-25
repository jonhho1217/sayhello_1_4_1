import 'package:flutter/material.dart';
import 'package:sayhello/utils/uidata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppBars extends StatelessWidget implements PreferredSizeWidget {
  final type;

  AppBars(this.type);

  Size get preferredSize => Size.fromHeight(kToolbarHeight);

   buildAppBar(String type, context) {
     AppBar bar;
     switch (type) {
       case "1":
         bar = new AppBar(
           title: Row(
             children: <Widget>[
               FlutterLogo(
                 colors: Colors.amber,
                 textColor: Colors.white,
               ),
               SizedBox(
                 width: 10.0,
               ),
               Text(UIData.appName)
             ],
           ),
           actions: <Widget>[
             IconButton(
               icon: Icon(Icons.playlist_play),
               onPressed: () => null,
             ),
             IconButton(
               icon: Icon(Icons.playlist_add),
               onPressed: () => null,
             ),
             IconButton(
               icon: Icon(Icons.playlist_add_check),
               onPressed: () => null,
             ),
           ],
         );
         break;
       default:
         break;
     }

    return bar;
  }

  @override
  Widget build(BuildContext context) {
    return buildAppBar(type, context);
  }
}