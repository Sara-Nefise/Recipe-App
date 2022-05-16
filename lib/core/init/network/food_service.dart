import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../feature/HomePage/model/category_card_model.dart';
import '../../../feature/HomePage/model/food_model.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //food eklemek için
  Future<Food> addStatus(
      String foodname, String description, int likes, String category) async {
    var ref = _firestore.collection("Food");

    var documentRef = await ref.add({
      'description': description,
      'foodName': foodname,
      'likes': likes,
      'category': category
    });

    return Food(
      id: documentRef.id,
      description: description,
      foodName: foodname,
      likes: likes,
      category: category,
    );
  }

  //food göstermek için
  Stream<QuerySnapshot> getFood(String catagoryName) {
    var ref;
    if (catagoryName == 'All') {
      ref = _firestore.collection("Food").snapshots();
    } else {
      ref = _firestore
          .collection("Food")
          .where('category', isEqualTo: catagoryName)
          .snapshots();
    }

    return ref;
  }

  //status silmek için
  Future<void> removeFood(String docId) {
    var ref = _firestore.collection("Food").doc(docId).delete();

    return ref;
  }

  Future<void> updateDataToFirestore(
      String documentName, Map<String, dynamic> model) async {
    await _firestore.collection("Food").doc(documentName).update(model);
  }

  Stream<QuerySnapshot> SearchFood(String searchFood) {
    var ref = _firestore
        .collection("Food")
        .where('foodName', isEqualTo: searchFood)
        .snapshots();

    return ref;
  }

  Stream<QuerySnapshot> filerFoodByCatagoryBytime(
      int cookingTime, String selectedCatagory) {
    var ref;
    if (selectedCatagory == 'All') {
      ref = _firestore.collection("Food").snapshots();
    } else {
      ref = _firestore
          .collection("Food")
          .where('category', isEqualTo: 'Food')
          .where('Time', isLessThanOrEqualTo: cookingTime)
          .snapshots();
    }
    return ref;
  }
}
