// returns Stream w/ Idea record and Attribute descendants

import 'dart:async';
import 'package:sayhello/logic/viewmodel/idea_attr_view_model.dart';
import 'package:sayhello/model/idea.dart';

class IdeaBloc {
  final _ideaVM = IdeaViewModel();
  final ideaController = StreamController<Idea>();

  Stream<Idea> get ideaItems => ideaController.stream;

  IdeaBloc() {
    ideaController.add(_ideaVM.getIdeaItems());
  }
}
