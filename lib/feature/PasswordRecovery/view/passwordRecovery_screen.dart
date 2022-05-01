import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';
import 'package:recipeapp/feature/newPassword/view/newPassword_screen.dart';

import '../../../core/constant/strings/passwordRecovery.dart';
import '../../../core/constant/strings/signUp_string.dart';
import '../../../product/widgets/ElevatedButton.dart';
import '../../../product/widgets/textFeild.dart';
import '../../SignUp/view/signUp_screen.dart';
import '../../VerificationCode/VerificationCode_screen.dart';

class PasswordRecoveryPage extends StatefulWidget {
  PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
                padding: context.paddingMedium,
                child: Column(
                  children: [
                    SizedBox(height: context.dynamicHeight(0.1)),
                    Text(PasswordRecover.revocerTitleText,
                        style: context.textTheme.headline3),
                    context.emptySizedHeightBoxLow,
                    Text(
                      PasswordRecover.enterPasswordText,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyText1
                          ?.copyWith(color: AppColors().darkGrey),
                    ),
                    context.emptySizedHeightBoxNormal,
                    _formFeild(),
                  ],
                )),
          ),
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
            _loginButton(),
          ],
        ));
  }

  _loginButton() {
    return MyElevatedButton(
        onpressedFun: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationPage(onpressedFun: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPasswordPage()));
                    })),
          );
        },
        buttonText: PasswordRecover.sentText);
  }
}
