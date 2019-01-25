import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:sayhello/model/attributes.dart';
import 'package:sayhello/model/idea.dart';
import 'package:sayhello/utils/uidata.dart';
import 'package:sayhello/utils/fs_parse.dart';
import 'package:sayhello/ui/widgets/appbars.dart';
import 'package:sayhello/ui/widgets/drawers.dart';

//import 'package:rxdart/rxdart.dart';
//import 'package:rxdart/streams.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdeasAttributePage extends StatefulWidget {
  @override
  _IdeasAttributePage createState() => new _IdeasAttributePage();
}

class _IdeasAttributePage extends State<IdeasAttributePage> {
  Size deviceSize;
  BuildContext _context;
  double width;
  double _imageHeight;
  double _imageWidth;
  double _photosHeight;
  double dotSize = 8.0;
  String appbartype = '1';
  final _atrscaffoldState = GlobalKey<ScaffoldState>();

  String iid;
  Stream<QuerySnapshot> currentiidStream;
  Future<List<Idea>> iidreferences;

  Idea ideaRcd;
  List<Attributes> ideaAttrs = List();

  AppDrawer menudrawer;

  void _buildVert(Size deviceSize) {
    _imageHeight = 256;
    _imageWidth = 422;
    _photosHeight = deviceSize.height / 5;
  }

  void _buildHoriz(Size deviceSize) {
    _imageHeight = 226;
    _imageWidth = 532;
    _photosHeight = deviceSize.height / 4;
  }

  void initStreams() {
    setState(() {
      iid = initIID();
      currentiidStream = getIIDStream(iid);
    });
  }

//  void _updateQueryParms() {
//    setState(() {
//      iid = iid2;
//    });
//  }

  nullFunc() {
    return null;
  }

  initIID() {
    return 'demoid';
  }

  Stream getIIDStream(iid) {
    Stream<QuerySnapshot> currentiidStream = Firestore.instance
        .collection("demo")
        .where("iid", isEqualTo: iid)
        .snapshots();

    return currentiidStream;
  }

  Future<List<Idea>> buildIIDDescendants(iid) async {
    List<Idea> iidreference = new List();
    QuerySnapshot snapshot = await Firestore.instance
        .collection("demo")
        .where("iid", isEqualTo: iid)
        .getDocuments();
    DocumentSnapshot doc1 = snapshot.documents[0];

    List<String> iids = doc1['ideas'].cast<String>();

    for (final i in iids) {
      Idea iidref;
      QuerySnapshot snapshot = await Firestore.instance
          .collection("demo")
          .where("iid", isEqualTo: i)
          .getDocuments();
      DocumentSnapshot doc2 = snapshot.documents[0];
      iidref = new Idea(
          name: doc2['name'], image: doc2['image'], nameid: doc2['nameid']);
      iidreference.add(iidref);
    }

    return iidreference;
  }

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    iid = initIID();
    initStreams();
    iidreferences = buildIIDDescendants(iid);
  }

  Widget _appBar(String type) {
    return AppBars(type);
  }

  Widget homeScaffold(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Scaffold(
            appBar: _appBar(appbartype),
            key: _atrscaffoldState,
            endDrawer: AppDrawer(iidreferences),
            body: ideaSliverList()),
      );

  Widget ideaSliverList() {
    return StreamBuilder(
        stream: currentiidStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ideaRcd = parseIdea(snapshot, ideaRcd);
            Map<dynamic, dynamic> attrs = ideaRcd.attributes;
            ideaAttrs = parseAttribute(attrs, ideaAttrs);
          }

          return snapshot.hasData
              ? CustomScrollView(
                  slivers: <Widget>[ideaMain(ideaRcd), ideaAttrMain(ideaAttrs)],
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget ideaMain(ideaRcd) => SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return ideaBuildStack(context, ideaRcd);
        }, childCount: 1),
      );

  Widget ideaAttrMain(List<Attributes> ideaAttrs) => SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return ideaAttrBuildSliver(context, ideaAttrs[index]);
        }, childCount: ideaAttrs.length),
      );

  Widget ideaBuildStack(BuildContext context, ideaRcd) => InkWell(
        splashColor: Colors.blue[100],
        child: new Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            _buildImage(ideaRcd.image),
            _buildIdeaName(ideaRcd.name, ideaRcd.nameid)
          ],
        ),
      );

  Widget ideaAttrBuildSliver(BuildContext context, Attributes attribute) =>
      InkWell(
        splashColor: Colors.blue[100],
        child: _buildAttrList(attribute),
      );

  Widget _buildIdeaName(ideaName, ideaNameId) {
    return new Padding(
      padding: new EdgeInsets.only(left: 7.0, top: _imageHeight / 1.2),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  ideaName,
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  ideaNameId,
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAttrList(attribute) {
    if (attribute.type != 'photo') {
      return new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Row(
            children: <Widget>[
              new Padding(
                padding:
                    new EdgeInsets.symmetric(horizontal: 32.0 - dotSize / 2),
                child: new Container(
                    height: dotSize,
                    width: dotSize,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue)),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      attribute.value,
                      style: new TextStyle(fontSize: 18.0),
                    ),
                    new Text(
                      attribute.value,
                      style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ));
    } else {
      return new Container(
        height: _photosHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Photos",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
              ),
              Expanded(
                child: Card(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: attribute.photo.length,
                    itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(parsePhotos(attribute.photo, i)),
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _buildImage(uri) {
    return new ClipPath(
      clipper: new DiagonalClipper(),
      child: new Image.network(
        uri,
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        width: _imageWidth,
      ),
    );
  }

  Widget build(BuildContext context) {
    _context = context;
    width = MediaQuery.of(context).size.width;
    deviceSize = MediaQuery.of(context).size;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      _buildVert(deviceSize);
    } else {
      _buildHoriz(deviceSize);
    }

    return defaultTargetPlatform == TargetPlatform.iOS
        ? homeScaffold(context)
        : homeScaffold(context);
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 60.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
