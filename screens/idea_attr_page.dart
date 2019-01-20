import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sayhello/logic/bloc/idea_attr_bloc.dart';
import 'package:sayhello/model/idea.dart';
import 'package:sayhello/utils/uidata.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class IdeasAttributePage extends StatefulWidget {

  @override
  _IdeasAttributePage createState() => new _IdeasAttributePage();
}

class _IdeasAttributePage extends State<IdeasAttributePage> {
  Size deviceSize;
  BuildContext _context;
  double width;
  final _atrscaffoldState = GlobalKey<ScaffoldState>();

//  String iid;
//  String iid_new;
//  List Aid;
//  Stream<QuerySnapshot> currentiidStream;

//  void initState() {
//    super.initState();
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => initIID());
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => getIIDQuery(iid));
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => getAIDQuery(Aid));
//  }

//  void _updateQueryParms() {
//    setState(() {
//      iid = iid_new;
//    });
//  }
//
//  initIID () {
//    currentiidStream = Firestore.instance
//        .collection("demo")
//        .where("iid", isEqualTo: iid)
//        .snapshots();
//
//    setState(() {
//      iid = 'demo_id';
//    });
//  }
//
// getIIDQuery (iid) {
//   currentiidStream = Firestore.instance
//       .collection("demo")
//       .where("iid", isEqualTo: iid)
//       .snapshots();
//
//   return currentiidStream;
// }
//
//  getAIDQuery (aid) {
//    currentiidStream = Firestore.instance
//        .collection("demo")
//        .where("iid", isEqualTo: aid)
//        .snapshots();
//
//    return currentiidStream;
//  }

  Stream<QuerySnapshot> currentiidStream = Firestore.instance
        .collection("demo")
        .where("iid", isEqualTo: 'demoid')
        .snapshots();

//  Stream<QuerySnapshot> currentaidStream = Firestore.instance
//      .collection("attributes")
//      .where("attibutes/aid", isEqualTo: 'aid1').where("attibutes/aid", isEqualTo: 'aid2')
//      .where("attibutes/aid", isEqualTo: 'aid13').where("attibutes/aid", isEqualTo: 'aid4')
//      .snapshots();

  Widget appBar() => SliverAppBar(
        backgroundColor: Colors.black,
        pinned: true,
        elevation: 10.0,
        forceElevated: true,
        expandedHeight: 80.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          background: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: UIData.kitGradients3)),
          ),
          title: Row(
            children: <Widget>[
              FlutterLogo(
                colors: Colors.amber,
                textColor: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text("Idea")
            ],
          ),
        ),
      );

  Widget ideaMain(snapshot) => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(_context).orientation == Orientation.portrait
                  ? 1
                  : 1,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return ideaAttrStack(context, snapshot);
        }, childCount: 1),
      );

  Widget homeScaffold(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Scaffold(key: _atrscaffoldState, body: bodySliverList()),
      );

  Widget ideaAttrStack(BuildContext context, List<DocumentSnapshot> snapshot) =>
      InkWell(
//    onTap: () => redirect to attribute route page,
        splashColor: Colors.blue[100],
        child: buildideaMainCard(snapshot),
      );

  buildideaMainCard(List<DocumentSnapshot> snapshot) {
    // TRY
    DocumentSnapshot document = snapshot[0];

    Idea ideaRcd = new Idea(
      name: document['name'],
      image: document['image'],
      ideas: document['ideas'].cast<String>(),
      attributes: document['attributes'].cast<String>(),
    );

    return Container(
//      height: deviceSize.height * 0.24,
      alignment: Alignment.topCenter,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Idea name:"+ideaRcd.name+"|Idea Attribute 1:Some Text|Idea Attribute 2:More Text...|Idea Attribute 3:More Text...|", style: TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width * 0.7,
                child: Image.network(ideaRcd.image),
              ),
            ),
          ],
        )

//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children<Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                child: Image.network(ideaRcd.image),
//              ),
//            ),
//
//          ]
//        ),
    );
  }

  Widget bodySliverList() {
//    IdeaBloc ideaBloc = IdeaBloc();
    return StreamBuilder(
        stream: currentiidStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? CustomScrollView(
                  slivers: <Widget>[
                    appBar(),
                    ideaMain(snapshot.data.documents)
//                    ideaAttrStack(context, snapshot.data.documents),
                  ],
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    width = MediaQuery.of(context).size.width;
    deviceSize = MediaQuery.of(context).size;
    return defaultTargetPlatform == TargetPlatform.iOS
        ? homeScaffold(context)
        : homeScaffold(context);
  }
}
