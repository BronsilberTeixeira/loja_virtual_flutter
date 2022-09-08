import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/products_data.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartTile extends StatefulWidget {
  final CartProduct cartProduct;
  const CartTile({Key key, this.cartProduct}) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState(cartProduct);
}

class _CartTileState extends State<CartTile> {
  final CartProduct cartProduct;
  _CartTileState(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      double price = cartProduct.productData.price * cartProduct.quantidade;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    "R\$ ${ price.toStringAsFixed(2) }",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove), 
                        color: Colors.deepOrange[900],
                        onPressed: cartProduct.quantidade == 1 
                        ? null 
                        : () {
                           setState(() {
                            CartModel.of(context).decCartItem(cartProduct);
                          });
                        }
                      ),
                      Text(cartProduct.quantidade.toString()),
                      IconButton(
                        icon: Icon(Icons.add), 
                        color: Colors.blue[500],
                        onPressed: () {
                          setState(() {
                            CartModel.of(context).incCartItem(cartProduct);
                          });
                        }
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            CartModel.of(context).removeCartItem(cartProduct);
                          });
                        }, 
                        icon: Icon(Icons.delete_outline),
                        color: Colors.amber[800],
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