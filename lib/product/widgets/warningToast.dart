import 'package:fluttertoast/fluttertoast.dart';

import '../../core/init/theme/color/color_theme.dart';

Future<bool?> warningToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColors().red,
        textColor: AppColors().white,
        fontSize: 14);
  }