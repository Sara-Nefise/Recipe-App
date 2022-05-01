import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';

import '../../../core/constant/strings/signUp_string.dart';
import '../../../core/init/network/firbase_auth.dart';
import '../../../product/widgets/ElevatedButton.dart';
import '../../../product/widgets/textFeild.dart';
import '../../PasswordRecovery/view/passwordRecovery_screen.dart';
import '../../SignIn/view/signIn_screen.dart';
import '../../VerificationCode/VerificationCode_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool? sixChars = false;
  bool? number = false;
  bool visiblity = false;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {
        sixChars = _passwordController.text.length >= 6;
        number = _passwordController.text.contains(RegExp(r'\d'), 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(height: context.dynamicHeight(0.1)),
                  Text(SignUpString.welcomeText,
                      style: context.textTheme.headline3),
                  context.emptySizedHeightBoxLow,
                  Text(
                    SignUpString.enterAccountText,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyText1
                        ?.copyWith(color: AppColors().darkGrey),
                  ),
                  context.emptySizedHeightBoxNormal,
                  _formFeild(),
                ],
              )),
        ));
  }

  _formFeild() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CutsomTextformField(
                codeController: _emailController,
                focusNode: _emailNode,
                labelText: SignUpString.emailText,
                prefixIcon: Icons.email,
                suffixIcon: null,
                textInputType: TextInputType.emailAddress,
                isPassword: false),
            context.emptySizedHeightBoxNormal,
            CutsomTextformField(
              codeController: _passwordController,
              focusNode: _passwordNode,
              labelText: SignUpString.passwordText,
              prefixIcon: Icons.lock,
              suffixIcon: Icons.visibility,
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            SizedBox(height: context.dynamicHeight(0.025)),
            context.emptySizedHeightBoxLow,
            _passwordNode.hasFocus
                ? SizedBox(
                    height: context.dynamicHeight(0.2),
                    child: Visibility(
                      child: _checkboxes(),
                      visible: true,
                    ))
                : SizedBox(
                    height: context.dynamicHeight(0.1),
                  ),
            context.emptySizedHeightBoxLow,
            _signUpButton(),
          ],
        ));
  }

  _checkboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          child: Text(
            SignUpString.rulesText,
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.all(5),
        ),
        Row(
          children: [
            Checkbox(
              checkColor: AppColors().turkuaz,
              activeColor: AppColors().green,
              onChanged: (bool? value) {
                setState(() {});
              },
              value: sixChars,
            ),
            Text(SignUpString.charactersText,
                style: context.textTheme.caption?.copyWith(fontSize: 16)),
          ],
        ),
        Row(
          children: [
            Checkbox(
              checkColor: AppColors().turkuaz,
              activeColor: AppColors().green,
              onChanged: (bool? value) {
                setState(() {
                  // isEmailUpdatesOn = value;
                });
              },
              value: number,
            ),
            Text(SignUpString.numberText,
                style: context.textTheme.caption?.copyWith(fontSize: 16)),
          ],
        )
      ],
    );
  }

  _signUpButton() {
    return MyElevatedButton(
      onpressedFun: () {
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          _authService
              .createPerson(
            _emailController.text,
            _passwordController.text,
          )
              .then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationPage(
                        onpressedFun: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                      )),
            );
          }).catchError((error) {
            _warningToast(error.toString());
          });
        } else {
          _warningToast('DietText.emptyText');
        }
      },
      buttonText: SignUpString.signUpText,
    );
  }

  Future<bool?> _warningToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColors().red,
        textColor: AppColors().white,
        fontSize: 14);
  }
}
