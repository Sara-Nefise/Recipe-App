import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';
import 'package:recipeapp/product/widgets/customElevatedButton.dart';

import '../../../product/widgets/ElevatedButton.dart';
import '../../../product/widgets/customSlider.dart';
import '../../../product/widgets/textFeild.dart';

class AddFoodItem extends StatefulWidget {
  AddFoodItem({Key? key}) : super(key: key);

  @override
  State<AddFoodItem> createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _foodNameNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  double value = 10;
  double cookingTime = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text('Cancel',
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(color: AppColors().red))),
                        Text('1/2', style: context.textTheme.bodyLarge)
                      ],
                    )),
                Expanded(child: _imageSelector(context), flex: 2),
                SizedBox(height: context.dynamicHeight(0.03)),
                Expanded(child: _form(), flex: 5)
              ],
            )),
        padding: context.paddingMedium,
      ),
    );
  }

  Container _imageSelector(BuildContext context) {
    return Container(
        width: 350,
        height: 180,
        decoration: DottedDecoration(
            strokeWidth: 2,
            dash: const [8, 8],
            shape: Shape.box,
            borderRadius: context.normalBorderRadius,
            color: AppColors().darkGrey),
        child: Column(
          children: [
            SizedBox(height: context.dynamicHeight(0.03)),
            SizedBox(
                child: Icon(Icons.image, size: 60, color: AppColors().grey)),
            Text(
              'Add Cover Photo',
              style: context.textTheme.bodyLarge,
            ),
            SizedBox(height: context.dynamicHeight(0.01)),
            Text(
              '(up to 12 Mb)',
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: AppColors().darkGrey),
            )
          ],
        ));
  }

  _form() {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text('Food Name', style: context.textTheme.bodyLarge),
              flex: 1),
          SizedBox(height: context.dynamicHeight(0.005)),
          Expanded(
              child: CutsomTextformField(
                codeController: _foodNameController,
                focusNode: _foodNameNode,
                labelText: 'Enter Food Name',
                suffixIcon: null,
                prefixIcon: null,
                textInputType: TextInputType.text,
                isdiscription: false,
              ),
              flex: 2),
          SizedBox(height: context.dynamicHeight(0.02)),
          Expanded(
              child: Text('Description', style: context.textTheme.bodyLarge),
              flex: 1),
          SizedBox(height: context.dynamicHeight(0.005)),
          Expanded(
              child: CutsomTextformField(
                isPassword: false,
                codeController: _descriptionController,
                focusNode: _descriptionNode,
                labelText: 'Tell a little about your food',
                suffixIcon: null,
                prefixIcon: null,
                textInputType: TextInputType.multiline,
                isdiscription: true,
              ),
              flex: 4),
          SizedBox(height: context.dynamicHeight(0.02)),
          Expanded(
              child: Text('Cooking Duration (in minutes)',
                  style: context.textTheme.bodyLarge),
              flex: 1),
          SizedBox(height: context.dynamicHeight(0.02)),
          Expanded(
              child: CustomSilder(
                cookingTime: cookingTime,
                value: value,
              ),
              flex: 3),
          Expanded(
              child: MyElevatedButton(onpressedFun: () {}, buttonText: 'Next'),
              flex: 2),
        ],
      ),
    );
  }
}
