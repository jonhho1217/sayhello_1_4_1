import 'package:flutter/material.dart';

import 'package:sayhello/services/email/email_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayhello/screens/home_page.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;

  var _fldEmail = TextEditingController();
  var _fldName = TextEditingController();
  var _fldPW = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _fldEmail,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Email Address is required';
              }
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _fldName,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Username is required';
              }
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _fldPW,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Password cannot be empty';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services and Privacy Policy',
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Register'),
                color: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      SnackBar snackBar = SnackBar(content: Text('Submitting Registration...'));
      Scaffold.of(context).showSnackBar(snackBar);

      var emailHandler = new EmailAuth();

      List signupReturn = new List(2);
      signupReturn = await emailHandler.handleSignUp(_fldEmail.value.text, _fldPW.value.text);

      if (signupReturn[0] != null) {
        FirebaseUser user = signupReturn[0];

        snackBar = SnackBar(content: Text('User Created'));
        Scaffold.of(context).showSnackBar(snackBar);

        Firestore.instance.collection('users').document(user.uid).setData({
          'email': _fldEmail.value.text,
          'name': _fldName.value.text,
          'uid': user.uid,
        });

        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute // go to Account Balance page
          (builder: (BuildContext context) => ChatScreen(user.displayName)));
      }
      else {
        snackBar = SnackBar(content: Text(signupReturn[1]));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
