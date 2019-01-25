import 'package:flutter/material.dart';


class Idea {
  String name;
  String image;
  String nameid;
  Map<dynamic, dynamic> attributes;
  List<String> ideas;
  BuildContext context;

  Idea(
      {this.name,
        this.image,
        this.nameid,
        this.attributes,
        this.ideas,
        this.context,});
}
