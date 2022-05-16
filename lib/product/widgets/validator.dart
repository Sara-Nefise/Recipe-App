import 'package:flutter/src/widgets/framework.dart';

class Validator {
  String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailReq = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (email.isEmpty) {
      return 'Please Enter Your Email';
    } else if (!emailReq.hasMatch(email)) {
      return 'Please Enter Valid Email';
    }
    return null;
  }

  String? validatePassword(
      {required String? password, bool? six, bool? number}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Please Enter Your Password';
    } else if (password.length <= 6 &&
        password.contains(RegExp(r'\d'), 0) == false) {
      return 'enter at least 7 words';
    }
  }
}
