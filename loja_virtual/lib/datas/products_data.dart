import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;
  String id;
  String title;

  double price;
  
  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data["title"];
    price = snapshot.data["price"] + 0.0;
    sizes = snapshot.data["sizes"];
    images = snapshot.data["img"];
  }
}