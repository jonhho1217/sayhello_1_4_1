// assets for login page

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sayhello/screens/register_page.dart';
import 'package:sayhello/services/login_services.dart';
import 'package:sayhello/services/google/google_auth.dart';
import 'package:sayhello/services/google/google_sign_in.dart';
import 'package:sayhello/services/firebase_config.dart';
import 'package:sayhello/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GoogleSignInAccount _currentGmail;
  bool submitting = false;
  bool rememberMe = false;

  void _checkLastLogin() async {}

  var _fldUserID = TextEditingController();
  var _fldPW = TextEditingController();

  double logowidth;
  double logoheight;
  double loginwidth;

  void toggleSubmitState() {
    setState(() {
      submitting = !submitting;
    });
  }

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkLastLogin());
    initFireStore();

    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentGmail = account;
      });
    });
    googleSignIn.signInSilently().then((user) {
      if (user != null) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Logging In with Gmail...')));
        Navigator.of(context).push(MaterialPageRoute
      (builder: (BuildContext context) => ChatScreen(user.displayName)));
      }
    });
  }

  Widget build(BuildContext context) {
    Orientation orient = MediaQuery.of(context).orientation;

    if (orient == Orientation.portrait) {
      logowidth = 30.0;
      logoheight = 30.0;
      loginwidth = MediaQuery.of(context).size.width * 0.6;
    } else {
      logowidth = 30.0;
      logoheight = 30.0;
      loginwidth = MediaQuery.of(context).size.width * 0.32;
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 56.0,
        child: Image.asset('assets/icons/flutter-logo.png'),
      ),
    );

    final name = Text(
      'SayHello',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: 30.0,
      ),
    );

    final userId = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: _fldUserID,
      decoration: InputDecoration(
        hintText: 'User Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      style: new TextStyle(color: Colors.white),
    );

    final pw = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: _fldPW,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      style: new TextStyle(color: Colors.white),
    );

    final loginButton = Container(
      width: loginwidth,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          minWidth: 65.0,
          height: 49.0,
          onPressed: () async {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            _scaffoldKey.currentState.showSnackBar(
                new SnackBar(content: new Text('Logging In...')));
            await loginInitial(
                _fldUserID.value.text, _fldPW.value.text, rememberMe, context, _scaffoldKey);
            _scaffoldKey.currentState.hideCurrentSnackBar();

          },
          color: const Color(0xFF6BBEFF),
          child: !submitting
              ? new Text('Login',
                  style: TextStyle(color: Colors.white, fontSize: 18.0))
              : const Center(child: const CircularProgressIndicator()),
        ),
      ),
    );

    final register = FlatButton(
        child: new Text('Create an account',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: () {
          Navigator.pushNamed(context, RegisterPage.routeName);
        });

    buildLogin(BuildContext context) {
      ListView outpage = ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          logo,
          name,
          SizedBox(height: 20.0),
          userId,
          SizedBox(height: 8.0),
          pw,
          SizedBox(height: 10.0),
          loginButton,
          register,
        ],
      );
      return outpage;

//      if (orient == Orientation.portrait) {
//      } else {
//      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(119, 94 ,93, 1.0),
      body: Center(
        child: buildLogin(context),
      ),
      floatingActionButton: GSignIn(
        auth: GoogleAuth(
            firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()),
      ),
    );
  }
}
