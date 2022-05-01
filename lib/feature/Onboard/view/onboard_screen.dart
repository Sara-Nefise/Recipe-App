import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/constant/strings/onboard_string.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';
import 'package:recipeapp/product/widgets/ElevatedButton.dart';

import '../../SignIn/view/signIn_screen.dart';

class OnboardPage extends StatefulWidget {
  OnboardPage({Key? key}) : super(key: key);

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: Column(children: [
              context.emptySizedHeightBoxLow,
              _onbaordImage(context),
              Text(OnboardString.startcook, style: context.textTheme.headline3),
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              _motovationText(context),
              context.emptySizedHeightBoxHigh,
              Padding(
                padding: context.horizontalPaddingMedium,
                child: MyElevatedButton(
                  onpressedFun: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  buttonText: OnboardString.getstart,
                ),
              ),
              const Spacer(flex: 1)
            ])));
  }

  Center _motovationText(BuildContext context) {
    return Center(
        child: Text(
      OnboardString.motovationText,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyText1?.copyWith(color: AppColors().darkGrey),
    ));
  }

  SizedBox _onbaordImage(BuildContext context) {
    return SizedBox(
      child: Image.asset('assets/images/Onboarding.png'),
      height: context.dynamicHeight(0.6),
      width: double.infinity,
    );
  }
}
