import 'package:flutter/material.dart';

class Idea {
  String name;
  String image;
  List<String> attributes;
  List<String> ideas;
  BuildContext context;

  Idea(
      {this.name,
        this.image,
        this.attributes,
        this.ideas,
        this.context,});
}
