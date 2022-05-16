import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';
import 'package:recipeapp/feature/SignIn/view/signIn_screen.dart';
import 'package:recipeapp/product/widgets/ElevatedButton.dart';

import '../../../core/constant/strings/newPassword_string.dart';
import '../../../core/constant/strings/passwordRecovery.dart';
import '../../../core/constant/strings/signUp_string.dart';
import '../../../product/widgets/textFeild.dart';

class NewPasswordPage extends StatefulWidget {
  NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool? sixChars = false;
  bool? number = false;
  bool visiblity = false;

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
        // appBar: AppBar(
        //   leading: Icon(Icons.arrow_back),
        //   actions: [],
        // ),
        body: Container(
            child: Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, right: 30, left: 30),
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: context.dynamicHeight(0.1)),
          Text(NewPassword.resetText, style: context.textTheme.headline3),
          context.emptySizedHeightBoxLow,
          Text(
            NewPassword.passwordTitleText,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyText1
                ?.copyWith(color: AppColors().darkGrey),
          ),
          context.emptySizedHeightBoxNormal,
          _formFeild(),
        ],
      )),
    )));
  }

  _formFeild() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CutsomTextformField(
              isdiscription: false,
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
            _loginButton(),
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
              checkColor: AppColors().green,
              activeColor: AppColors().turkuaz,
              onChanged: (bool? value) {},
              value: sixChars,
              // shape: OutlinedBorder(side: ),
            ),
            Text(SignUpString.charactersText,
                style: context.textTheme.caption?.copyWith(fontSize: 16)),
          ],
        ),
        Row(
          children: [
            Checkbox(
              checkColor: AppColors().green,
              activeColor: AppColors().turkuaz,
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

  _loginButton() {
    return MyElevatedButton(
        onpressedFun: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInPage()));
        },
        buttonText: NewPassword.doneText);
  }
}
