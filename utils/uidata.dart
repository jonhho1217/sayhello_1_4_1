import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {
  //routes
  static const String homeRoute = "/home";
  static const String profileOneRoute = "/View Profile";
  static const String profileTwoRoute = "/Profile 2";
  static const String myIdeaAttributeRoute = "/My Ideas";
  static const String notFoundRoute = "/No Search Result";
  static const String settingsOneRoute = "/Device Settings";
  static const String loginOneRoute = "/Login With OTP";
  static const String loginTwoRoute = "/Login 2";

  //strings
  static const String appName = "SayHello";

  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

  //images
  static const String imageDir = "assets/images";
  static const String pkImage = "$imageDir/flutter-logo.png";
  static const String profileImage = "$imageDir/profile-icon.png";
  static const String ideasImage = "$imageDir/ideas-icon.png";
  static const String blankImage = "$imageDir/flutter-logo.png";
  static const String settingsImage = "$imageDir/settings-icon.png";
  static const String messagesImage = "$imageDir/messages-icon.png";
  static const String helpImage = "$imageDir/help-icon.png";
  static const String webImage = "$imageDir/website-icon.png";

  //login
  static const String enter_code_label = "Phone Number";
  static const String enter_code_hint = "10 Digit Phone Number";
  static const String enter_otp_label = "OTP";
  static const String enter_otp_hint = "4 Digit OTP";
  static const String get_otp = "Get OTP";
  static const String resend_otp = "Resend OTP";
  static const String login = "Login";
  static const String enter_valid_number = "Enter 10 digit phone number";
  static const String enter_valid_otp = "Enter 4 digit otp";

  //gneric
  static const String error = "Error";
  static const String success = "Success";
  static const String ok = "OK";
  static const String forgot_password = "Forgot Password?";
  static const String something_went_wrong = "Something went wrong";
  static const String coming_soon = "Coming Soon";

  static const MaterialColor ui_kit_color = Colors.grey;

//colors
  static List<Color> kitGradients = [
//    Colors.blueGrey.shade800,
    Colors.indigo.shade400,
    Colors.black54,
  ];
  static List<Color> kitGradients2 = [
    Colors.teal.shade600,
    Colors.blueGrey.shade600
  ];

  static List<Color> kitGradients3 = [
    Colors.green.shade300,
    Colors.blueGrey.shade600,
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
