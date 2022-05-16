import 'package:cloud_firestore/cloud_firestore.dart';

class FoodCategory {
  String category;
  bool selected;

  FoodCategory({required this.category, required this.selected});
}
