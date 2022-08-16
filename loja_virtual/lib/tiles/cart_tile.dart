import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/products_data.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  const CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("products").document(cartProduct.category)
            .collection("itens").document(cartProduct.pid).get(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              cartProduct.productData = ProductData.fromDocument(snapshot.data);
            } else {
              return Container(
                height: 70,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          },
        ),
    );
  }
}