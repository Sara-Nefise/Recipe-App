import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';

import '../../../../core/constant/strings/signUp_string.dart';

class SecondTrial extends StatefulWidget {
  @override
  _SecondTrialState createState() => _SecondTrialState();
}

class _SecondTrialState extends State<SecondTrial> {
  final _codeController = TextEditingController();
  final _codeFocus = FocusNode();

  String _code = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) {
                    String text = '';
                    if (_code.length > index) {
                      text = _code[index];
                    }
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(_codeFocus);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 65,
                        height: 60,
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          border: Border.all(
                            width: text.isEmpty ? 1 : 1.5,
                            color: text.isEmpty
                                ? theme.shadowColor.withOpacity(0.1)
                                : AppColors().green,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          text,
                          style: context.textTheme.headline5,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                visible: false,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                maintainInteractivity: true,
                child: TextField(
                  controller: _codeController,
                  focusNode: _codeFocus,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _code = val;
                    });

                    if (val.length == 4) {
                      _codeFocus.unfocus();
                    }
                    print(_code);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
