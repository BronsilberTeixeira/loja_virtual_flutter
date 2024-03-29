import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

  UserModel user;

  List<CartProduct> products = [];

  String cupomCode;
  int discountPercent = 0;

  bool isLoadding = false;

  CartModel(this.user) {
    if(user.isLoggedIn()){
    _loadItens();
    }
  }

  static CartModel of(BuildContext context) => 
    ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance.collection("users").document(user.firebaseUser.uid).
      collection("cart").add(cartProduct.toMap()).then((doc) {
        cartProduct.cid = doc.documentID;
      });

      notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance.collection("users").document(user.firebaseUser.uid).
      collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decCartItem(CartProduct cartProduct) {
    cartProduct.quantidade --;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").
     document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

    void incCartItem(CartProduct cartProduct) {
    cartProduct.quantidade ++;

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").
     document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadItens() async {
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").
      getDocuments();
      products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
      notifyListeners();
  }
}