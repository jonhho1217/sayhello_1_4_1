import 'package:flutter/material.dart';
import 'package:sayhello/model/idea.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class IdeaViewModel {
  Idea ideaItems;
  Idea ideaRcd;
  IdeaViewModel({this.ideaItems});

  getIdeaItems() {
    Future<Idea> getDemoIdea () async {
      var data = await Firestore.instance.collection("demo").where("iid", isEqualTo: 'demoid').getDocuments();

      var rcd = data.documents[0];

//       if (list.length==1) {
//
//       }

      Idea ideaRcd = new Idea(
        name: rcd['name'],
        image: rcd['image'],
        ideas: rcd['ideas'].cast<String>(),
        attributes: rcd['attributes'].cast<String>(),
      );
      return ideaRcd;
    }

    getDemoIdea().then((Idea ideaRcd) {
      return ideaItems;
    });
  }
}