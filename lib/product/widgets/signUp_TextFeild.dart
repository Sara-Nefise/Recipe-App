import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/product/widgets/validator.dart';

import '../../core/constant/strings/signUp_string.dart';
import '../../core/init/theme/color/color_theme.dart';

class SignUpTextformField extends StatefulWidget {
  final TextEditingController codeController;
  final TextInputType textInputType;
  final String labelText;
  bool isPassword;
  final FocusNode focusNode;
  var prefixIcon;
  var suffixIcon;
  Color fillcolor;
  SignUpTextformField(
      {Key? key,
      required this.codeController,
      required this.textInputType,
      required this.labelText,
      this.isPassword = true,
      required this.focusNode,
      required this.prefixIcon,
      required this.suffixIcon,
      this.fillcolor = Colors.white})
      : super(key: key);

  @override
  State<SignUpTextformField> createState() => _SignUpTextformFieldState();
}

class _SignUpTextformFieldState extends State<SignUpTextformField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        // if (widget.labelText == SignUpString.passwordText) {
        //   return Validator().validatePassword(password: value);
        // }
        if (widget.labelText == SignUpString.emailText) {
          return Validator().validateEmail(email: value);
        }
      },
      focusNode: widget.focusNode,
      controller: widget.codeController,
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword,
      decoration: _emailfeild(context),
      // style: TextStyle(),
      maxLines: 1,
    );
  }

  InputDecoration _emailfeild(BuildContext context) {
    return InputDecoration(
        fillColor: widget.fillcolor,
        contentPadding: const EdgeInsets.all(17),
        hintStyle: context.textTheme.headline6
            ?.copyWith(fontSize: 17, color: AppColors().darkGrey),
        hintText: widget.labelText,
        prefixIcon: Icon(
          widget.prefixIcon,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors().green, width: 2.0),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors().grey, width: 2.0),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 233, 120, 120), width: 3.0),
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: InkWell(
          child: Icon(
            widget.suffixIcon,
          ),
          onTap: () {
            setState(() {
              widget.isPassword = !widget.isPassword;
              widget.isPassword == true
                  ? widget.suffixIcon = Icons.visibility
                  : widget.suffixIcon = Icons.visibility_off;
            });
          },
        ));
  }
}
