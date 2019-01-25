//import 'package:flutter/material.dart';
import 'package:sayhello/model/attributes.dart';
import 'package:sayhello/model/idea.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Idea parseIdea(snapshot, ideaRcd) {
  Idea ideaRcd2;

  List<DocumentSnapshot> snap = snapshot.data.documents;

  if (snap.length == 1) {
    DocumentSnapshot document = snapshot.data.documents[0];

    Map<dynamic, dynamic> attrs = document['attributes'];

    ideaRcd2 = new Idea(
      name: document['name'],
      image: document['image'],
      nameid: document['nameid'],
      ideas: document['ideas'].cast<String>(),
      attributes: attrs,
    );
  }

    if (ideaRcd!=ideaRcd2) {
      return ideaRcd2;
    }

    else {
      return ideaRcd;
    }


}

List<Attributes> parseAttribute(Map<dynamic, dynamic> attrs, List<Attributes> ideaAttrs1) {
  List<Attributes> ideaAttrs2 = new List<Attributes>();
  List<String> photourl = new List<String>();

    void buildAttrslist(key, value) {
      Attributes oneattr;
      Map hold = attrs[key];

      if (hold.containsKey('photo')) {
        photourl = List.from(hold['photo']);
      } else {
        photourl = null;
      }

      oneattr = new Attributes(
        type: hold['type'],
        value: hold['value'],
        photo: photourl,
      );

      switch (oneattr.type) {
        case "name":
          ideaAttrs2.insert(0, oneattr);
          break;
        case "description":
          ideaAttrs2.insert(1, oneattr);
          break;
        default:
          ideaAttrs2.add(oneattr);
          break;
      }
    }

    attrs.forEach(buildAttrslist);

    if (ideaAttrs1!=ideaAttrs2) {
      return ideaAttrs2;
    }
    else {
      return ideaAttrs1;
    }
  }

String parsePhotos(attrs, index) {
  List<String> netphotos = attrs;
  String netphoto = netphotos[index];

  return netphoto;
}