import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';

import '../../core/constant/strings/verication_string.dart';
import '../../core/init/network/firbase_auth.dart';
import '../../product/widgets/counter.dart';
import '../../product/widgets/warningToast.dart';

class VerificationPage extends StatefulWidget {
  final VoidCallback onpressedFun;
  VerificationPage({Key? key, required this.onpressedFun}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  User? user = FirebaseAuth.instance.currentUser;
  late Timer timer;
  Duration get duration => controller.duration! * controller.value;
  bool get expired => duration.inSeconds == 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //       icon: Icon(Icons.arrow_back),
        //       onPressed: () {
        //         controller.dispose();
        //         Navigator.pop(context);
        //       }),
        // ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 16, right: 30, left: 30),
                child: Column(
                  children: [
                    SizedBox(height: context.dynamicHeight(0.1)),
                    Text(Verification.checkemailText,
                        style: context.textTheme.headline3),
                    context.emptySizedHeightBoxLow,
                    Text(
                      Verification.emailText,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyText1
                          ?.copyWith(color: AppColors().darkGrey),
                    ),
                    //context.emptySizedHeightBoxNormal,
                    // SecondTrial(),
                    context.emptySizedHeightBoxNormal,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Verification.expiresTimeText,
                            style: context.textTheme.bodyText1
                                ?.copyWith(fontSize: 19)),
                        TimeCounter(
                          controller: controller,
                        ),
                      ],
                    ),
                    context.emptySizedHeightBoxNormal,
                    SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                            onPressed: widget.onpressedFun,
                            child: Text(Verification.verifyText))),
                    context.emptySizedHeightBoxLow3x,
                    SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                            onPressed: _disablebutton(),
                            child: Text(Verification.resendText)))
                  ],
                )),
          ),
        ));
  }

  Future<void> checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      controller.dispose();
      timer.cancel;
      warningToast('done');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    AuthService().sendVerificationEmail();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    );
    controller.reverse(from: 1);
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
  }

  _disablebutton() {
    return (duration.inSeconds == 00 && duration.inMinutes == 00)
        ? () {
            setState(() {
              controller.reverse(from: 1);
              AuthService().sendVerificationEmail();
            });
          }
        : null;
  }
}
