import 'package:flutter/material.dart';

import 'package:sayhello/model/idea.dart';
import 'package:sayhello/utils/uidata.dart';

class AppDrawer extends StatelessWidget {
  final Future<List<Idea>> iidrefs;

  AppDrawer(this.iidrefs);

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> menuitems = new List<Widget>();
            var data = snapshot.data;

            menuitems.add(
                Container(
                  height: 80.0,
                  child: DrawerHeader(
                    child: Image.asset(UIData.pkImage),
                    decoration: new BoxDecoration(color: Colors.blue),
                  ),
                ));

            menuitems.add(Divider());

            for (final Idea i in data) {
              menuitems.add(new Container(
                height: 80.0,
                child: ListTile(
                  leading: new Image.network(
                    i.image,
                    fit: BoxFit.cover,
                  ),
                  title: Text(i.name, style: TextStyle(color: Colors.white)),
                  subtitle: Text(i.nameid, style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {},
                ),
              ));
            }

            return new ListView(children: menuitems);
          } else {
            return new Text("Loading");
          }
        },
        future: iidrefs,
      ),
    );
  }
}