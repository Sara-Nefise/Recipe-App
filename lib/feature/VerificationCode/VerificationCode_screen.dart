import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';
import '../../product/widgets/checkBox.dart';
import '../../product/widgets/counter.dart';

import '../../core/constant/strings/verication_string.dart';

class VerificationPage extends StatefulWidget {
  final VoidCallback onpressedFun;
  VerificationPage({Key? key, required this.onpressedFun}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  Duration get duration => controller.duration! * controller.value;
  bool get expired => duration.inSeconds == 0;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    );
    controller.reverse(from: 1);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                controller.dispose();
                Navigator.pop(context);
              }),
        ),
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
                    context.emptySizedHeightBoxNormal,
                    SecondTrial(),
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
                            onPressed: (duration.inSeconds == 00 &&
                                    duration.inMinutes == 00)
                                ? () {
                                    setState(() {
                                      controller.reverse(from: 1);
                                    });
                                  }
                                : null,
                            child: Text(Verification.resendText)))
                  ],
                )),
          ),
        ));
  }
}
