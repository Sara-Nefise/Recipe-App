import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';

import '../../../core/constant/strings/signIn_string.dart';
import '../../../core/init/network/firbase_auth.dart';
import '../../../product/widgets/ElevatedButton.dart';
import '../../../product/widgets/textFeild.dart';
import '../../../product/widgets/warningToast.dart';
import '../../PasswordRecovery/view/passwordRecovery_screen.dart';
import '../../SignUp/view/signUp_screen.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, right: 30, left: 30),
          child: Column(
            children: [
              SizedBox(height: context.dynamicHeight(0.1)),
              Text(SignInString.welcomeText,
                  style: context.textTheme.headline3),
              context.emptySizedHeightBoxLow,
              Text(
                SignInString.enterAccountText,
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
                labelText: SignInString.emailText,
                prefixIcon: Icons.email,
                suffixIcon: null,
                textInputType: TextInputType.emailAddress,
                isPassword: false),
            context.emptySizedHeightBoxNormal,
            CutsomTextformField(
              codeController: _passwordController,
              focusNode: _passwordNode,
              labelText: SignInString.passwordText,
              prefixIcon: Icons.lock,
              suffixIcon: Icons.visibility,
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            SizedBox(height: context.dynamicHeight(0.025)),
            _forgetPassword(),
            context.emptySizedHeightBoxHigh,
            _loginButton(),
            context.emptySizedHeightBoxNormal,
            _continueText(),
            context.emptySizedHeightBoxNormal,
            _googleButton(),
            SizedBox(height: context.dynamicHeight(0.025)),
            _dontHavwAccount()
          ],
        ));
  }

  Text _continueText() {
    return Text(SignInString.contiueText,
        style:
            context.textTheme.bodyText1?.copyWith(color: AppColors().darkGrey));
  }

  RichText _dontHavwAccount() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: SignInString.dontHaveAccountText,
            style: context.textTheme.caption?.copyWith(fontSize: 17),
          ),
          TextSpan(
              text: SignInString.signUpText,
              style: context.textTheme.caption
                  ?.copyWith(fontSize: 17, color: AppColors().green),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                }),
        ],
      ),
    );
  }

  SizedBox _googleButton() {
    return SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: AppColors().red),
            onPressed: () {
              _authService.signInWithGoogle().then((value) {
                return warningToast('done google');
                //  Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => const HomePage()),
                //     (route) => false);
              });
            },
            child: Text(SignInString.googleText)));
  }

  _loginButton() {
    return MyElevatedButton(
        onpressedFun: () {
          if (_emailController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty) {
            _authService
                .signInWithEmail(
              _emailController.text,
              _passwordController.text,
            )
                .then((value) {
              warningToast('done');
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) =>  HomePage()),
              //     (route) => false);
            }).catchError((error) {
              if (error.toString().contains('invalid-email')) {
                warningToast('DietText.loginWrongEmailText');
              } else if (error.toString().contains('user-not-found')) {
                warningToast('DietText.loginNoAccountText');
              } else if (error.toString().contains('wrong-password')) {
                warningToast('DietText.loginWrongPasswordText');
              } else {
                warningToast('DietText.errorText');
              }
            });
          } else {
            warningToast('DietText.emptyText');
          }
        },
        buttonText: SignInString.loginText);
  }

  Align _forgetPassword() {
    return Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PasswordRecoveryPage()),
            );
          },
          child: Text(
            SignInString.forgetpassText,
            style: context.textTheme.caption?.copyWith(fontSize: 17),
          ),
        ));
  }
}
