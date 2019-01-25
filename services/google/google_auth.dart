//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//class GoogleAuth {
//  GoogleAuth({
//    @required this.googleSignIn,
//    @required this.firebaseAuth,
//  });
//
//  final GoogleSignIn googleSignIn;
//  final FirebaseAuth firebaseAuth;
//
//  Future<FirebaseUser> signInWithGoogle() async {
//    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
//    // TODO error handling for failures
//    final GoogleSignInAuthentication googleAuth =
//    await googleAccount.authentication;
//    return firebaseAuth.signInWithGoogle(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//  }
//
////  static Future<bool> _setUserFromFirebase(FirebaseUser user) async {
////
////    _idToken = await user?.getIdToken() ?? '';
////
////    _accessToken = '';
////
////    _isEmailVerified = user?.isEmailVerified ?? false;
////
////    _isAnonymous = user?.isAnonymous ?? true;
////
////    _providerId = user?.providerData[0]?.providerId ?? '';
////
////    _uid = user?.providerData[0]?.uid ?? '';
////
////    _displayName = user?.providerData[0]?.displayName ?? '';
////
////    _photoUrl = '';
////
////    _email = user?.providerData[0]?.email ?? '';
////
////    _user = user;
////
////    var id = _user?.uid ?? '';
////
////    return id.isNotEmpty;
////  }
//
//}
//
