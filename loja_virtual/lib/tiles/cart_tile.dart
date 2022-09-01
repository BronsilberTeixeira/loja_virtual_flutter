import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/products_data.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  const CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: 120,
            child: Image.network(
              cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    cartProduct.productData.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  Text(
                    "tamanho: ${cartProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove), 
                        onPressed: () {}
                      ),
                      Text(cartProduct.quantidade.toString()),
                      IconButton(
                        icon: Icon(Icons.add), 
                        onPressed: () {}
                      ),
                      FlatButton(
                        onPressed: () {}, 
                        child: Text("remove"),
                        textColor: Colors.amber[800],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: cartProduct.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("products")
                    .document(cartProduct.category)
                    .collection("itens")
                    .document(cartProduct.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartProduct.productData =
                        ProductData.fromDocument(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContent()
        );
  }
}
