import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sayhello/services/email/email_auth.dart';
import 'package:sayhello/container/container.dart';
import 'package:sayhello/screens/register_page.dart';
import 'package:sayhello/screens/home_page.dart';

loginInitial(_parm1, _parm2, remember, BuildContext context, _scaffoldKey) async {

  var emailHandler = new EmailAuth();

  List signinReturn = new List(2);
  signinReturn = await emailHandler.handleSignInEmail(_parm1, _parm2);

  if (signinReturn[0] != null) {
    FirebaseUser user = signinReturn[0];

    Navigator.of(context).push(MaterialPageRoute // go to Account Balance page
      (builder: (BuildContext context) => ChatScreen(user.displayName)));
  }
  else {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(signinReturn[1])));
  }

}

Future<bool> badLogin(BuildContext context, msg) {
  // login failed, show msg w/ context
  return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });
}

//  Future<LoginPage> logoutWithGoogle() async {
//    await googleSignIn.signOut();
//    return new LoginPage();
//  }

Future existingUser(context, user, newUser) async {
  if (user != null) {
    // check new user
    final StateContainerState state = StateContainer.of(context);
    state.updateSession(user);

    var data = await Firestore.instance
        .collection("users")
        .where("uid", isEqualTo: user.uid)
        .getDocuments();
    var list = data.documents;

    if (list.length == 0) {
      // Add data to server if new user
      return true;
    } else {
      return false;
    }
  } else {
    // email auth failed...
  }
}

void showSnackBar(BuildContext context, String msg) {
  final SnackBar snackBar = SnackBar(content: Text(msg));

  Scaffold.of(context).showSnackBar(snackBar);
}

navigateToRegistration(user, BuildContext context) {
  Navigator.pushNamed(context, RegisterPage.routeName);
}


