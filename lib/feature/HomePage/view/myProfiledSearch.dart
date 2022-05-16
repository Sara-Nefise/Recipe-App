import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySearch extends StatefulWidget {
  const MySearch({Key? key}) : super(key: key);

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  static const String prefSearchKey = "previousSearches";
  bool inErrorState = false;
  List<String> previousSearches = [];
  var searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: CupertinoSearchTextField(
        padding: context.horizontalPaddingNormal,
        borderRadius: BorderRadius.circular(30),
        onChanged: (String value) {
          print('The text has changed to: $value');
        },
        onSubmitted: (String value) {
          if (!previousSearches.contains(value)) {
            previousSearches.add(value);
            savePreviousSearches();
            
          }
          print('Submitted text: $value');
        },
        prefixInsets: EdgeInsets.only(left: 15),
        controller: searchTextController,
      ),
    );
  }

  void getPreviousSearches() async {
    // 1
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 2
    if (prefs.containsKey(prefSearchKey)) {
      // 3
      previousSearches = prefs.getStringList(prefSearchKey)!;
      // 4

    }
  }

  void savePreviousSearches() async {
    // 1
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 2
    prefs.setStringList(prefSearchKey, previousSearches);
  }
}
