import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List> handleSignInEmail(String email, String password) async {
    List signupReturn = new List(2);
    String code;
    String message;

    final FirebaseUser user  = await auth.signInWithEmailAndPassword(
        email: email, password: password)
        .catchError((e) {

      code = e.code;
      message = e.message;
    });

    if (user !=null) {
      signupReturn[0] = user;
      return signupReturn;
    }
    else {
      signupReturn[0] = null;

      switch (code) {
        case "auth/invalid-email":
          signupReturn[1] = "This Email is invalid";
          break;
        case "auth/user-disabled":
          signupReturn[1] = "This Email User has been disabled";
          break;
        case "auth/user-not-found":
          signupReturn[1] = "Email User not found. Check Credentials";
          break;
        case "auth/wrong-password":
          signupReturn[1] = "Incorrect Password.  Check Credentials";
          break;
        default:
          signupReturn[1] = message;
          break;
      }

      return signupReturn;
    }
  }

  Future<List> handleSignUp(email, password) async {
    List signupReturn = new List(2);
    String code;
    String message;

    final FirebaseUser user  = await auth.createUserWithEmailAndPassword(
        email: email, password: password)
        .catchError((e) {

      code = e.code;
      message = e.message;
    });

    if (user !=null) {
      signupReturn[0] = user;
      return signupReturn;
    }
    else {
      signupReturn[0] = null;

      switch (code) {
        case "auth/email-already-in-use":
          signupReturn[1] = "This Email is already Registered";
          break;
        case "auth/invalid-email":
          signupReturn[1] = "This Email is invalid";
          break;
        case "auth/weak-password":
          signupReturn[1] = "The entered password is too weak";
          break;
        default:
          signupReturn[1] = message;
          break;
      }
      return signupReturn;
    }

  }
}

