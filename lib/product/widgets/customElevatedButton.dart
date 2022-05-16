import 'package:flutter/material.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';

import '../../core/constant/strings/onboard_string.dart';

class CustomElevatedButton extends StatefulWidget {
  final VoidCallback onpressedFun;
  final String buttonText;
  final bool isCancel;
  CustomElevatedButton(
      {Key? key,
      required this.onpressedFun,
      required this.buttonText,
      required this.isCancel})
      : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 60,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: widget.isCancel ? AppColors().grey : AppColors().green,
              onPrimary:
                  widget.isCancel ? AppColors().black : AppColors().white),
          onPressed: widget.onpressedFun,
          child: Text(widget.buttonText)),
    );
  }
}
