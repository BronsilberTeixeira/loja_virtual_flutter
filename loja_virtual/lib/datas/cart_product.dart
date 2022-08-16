import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/products_data.dart';

class CartProduct {
  String cid;
  String category;
  String pid;

  int quantidade;
  String size;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantidade = document.data["quantidade"];
    size = document.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantidade": quantidade,
      "size": size,
      // "product": productData.toResumeMap()
    };
  }
}