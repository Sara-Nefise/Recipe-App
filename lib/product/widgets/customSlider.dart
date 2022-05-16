import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../core/init/theme/color/color_theme.dart';

class CustomSilder extends StatefulWidget {
  double value = 10;
  double cookingTime = 10;

  CustomSilder({
    Key? key,
    required this.value,
    required this.cookingTime,
  }) : super(key: key);

  @override
  State<CustomSilder> createState() => _CustomSilderState();
}

class _CustomSilderState extends State<CustomSilder> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('<10',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: AppColors().green)),
            Text('30',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: AppColors().green)),
            Text('>60',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: AppColors().green)),
          ],
        ),
      ),
      SfSlider(
        activeColor: AppColors().green,
        stepSize: 20,
        min: 0.0,
        max: 40.0,
        interval: 20,
        labelFormatterCallback: (dynamic actualValue, String formattedText) {
          switch (actualValue) {
            case 0:
              widget.cookingTime = 10;
              return '<10';
            case 20:
              widget.cookingTime = 30;

              return '30';
            case 40:
              widget.cookingTime = 60;

              return '>60';
          }
          return actualValue.toString();
        },
        showTicks: true,
        showLabels: false,
        showDividers: true,
        value: widget.value,
        minorTicksPerInterval: 1,
        onChanged: (dynamic newValue) {
          setState(() {
            widget.value = newValue;
          });
        },
      )
    ]);
  }
}
