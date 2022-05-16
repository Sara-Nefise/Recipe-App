
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreference {
//   void startSearch(String value) {
//     setState(() {
//       if (!previousSearches.contains(value)) {
//         previousSearches.add(value);

//         savePreviousSearches();
//       }
//     });
//   }

//   void romveSearch(String key) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     await preferences.remove(key);
//   }

//   void getPreviousSearches() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey(prefSearchKey)) {
//       previousSearches = prefs.getStringList(prefSearchKey)!;
//     }
//   }

//   void savePreviousSearches() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList(prefSearchKey, previousSearches);
//     if (previousSearches.length > 3) {
//       setState(() {
//         previousSearches.removeAt(0);
//       });
//     }
//   }


// }