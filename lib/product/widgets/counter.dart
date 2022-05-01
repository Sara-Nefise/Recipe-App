import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';

class TimeCounter extends StatefulWidget {
  late AnimationController controller;

  TimeCounter({Key? key, required this.controller}) : super(key: key);

  @override
  _TimeCounterState createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter>
    with TickerProviderStateMixin {
  late AnimationController controller;
  Duration get duration => controller.duration! * controller.value;
  bool get expired => duration.inSeconds == 0;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, child) {
          return Text(
            _printDuration(duration),
            style: context.textTheme.bodyText1
                ?.copyWith(fontSize: 19, color: AppColors().red),
          );
        }
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
