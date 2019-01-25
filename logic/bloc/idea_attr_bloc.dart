//// returns Stream w/ Idea record and Attribute descendants
//
//import 'dart:async';
//import 'package:sayhello/logic/viewmodel/idea_attr_view_model.dart';
//import 'package:sayhello/model/idea.dart';
//
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//
//
//class IdeaBloc {
//  final _ideaVM = IdeaViewModel();
//  final ideaController = StreamController<QuerySnapshot>();
//
//  Stream<QuerySnapshot> iidSnaps = Stream.fromFuture(getIdeaItems());
//
//  ideaBlocReturn() {
//    return iidSnaps;
//  }
//}
//
//getIdeaItems() {
//  QuerySnapshot ideaItems;
//
//  Future getIidSnaps(iid) async{
//    QuerySnapshot iidsnaps = await Firestore.instance
//        .collection("demo")
//        .where("iid", isEqualTo: 'demo_id')
//        .getDocuments();
//
//    return iidsnaps;
//  }
//
//  getIidSnaps('demo_id').then((iidsnaps) {
//
//  });
//  return ideaItems;
//}