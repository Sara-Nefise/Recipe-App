import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:recipeapp/feature/HomePage/model/category_card_model.dart';

class Food {
  String id;
  String foodName;
  String description;
  int likes;
  String category;
  //List<String> ingredients;
//List<String> steps;

  Food({
    required this.id,
    required this.foodName,
    required this.description,
    required this.likes,
    required this.category,
  });

  factory Food.fromSnapshot(DocumentSnapshot snapshot) {
    return Food(
      id: snapshot.id,
      foodName: snapshot["foodName"],
      description: snapshot["description"],
      // ingredients: snapshot["ingredients"],
      likes: snapshot["likes"], category: snapshot["category"],
      //steps:snapshot["steps"],
    );
  }
}
