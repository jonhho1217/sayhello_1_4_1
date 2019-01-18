import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:sayhello/services/login_services.dart';
import 'package:sayhello/services/google/google_auth.dart';
import 'package:sayhello/screens/home_page.dart';

class GSignIn extends StatelessWidget {
  const GSignIn({
    @required this.auth,
  });

  final GoogleAuth auth;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _handleSignInGoogle(context),
      icon: Image.asset('assets/icons/google_g_logo.png', height: 24.0),
      label: const Text('Sign in with Google'),
    );
  }

  void _handleSignInGoogle(BuildContext context) {
    bool newUser;
    showSnackBar(context, 'Checking Gmail....');
    auth.signInWithGoogle().then((FirebaseUser user) {
      existingUser(context, user, newUser).then((newUser) {
//        if (newUser) {
//          navigateToRegistration(user, context);
//        }
//        else {
//
//        }
        showSnackBar(context, 'Welcome ${user.displayName}');
        Navigator.of(context).push(MaterialPageRoute
          (builder: (BuildContext context) => ChatScreen(user.displayName)));
      });
    });
  }

}

