import 'package:flutter/material.dart';

import '../../core/constant/strings/onboard_string.dart';

class MyElevatedButton extends StatefulWidget {
  final VoidCallback onpressedFun;
  final String buttonText;
  MyElevatedButton(
      {Key? key, required this.onpressedFun, required this.buttonText})
      : super(key: key);

  @override
  State<MyElevatedButton> createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
          onPressed: widget.onpressedFun, child: Text(widget.buttonText)),
    );
  }
}
