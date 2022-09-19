import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/products_data.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/category_screen.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/screens/product_screen.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
import 'package:loja_virtual/tiles/category_tile.dart';
import 'package:loja_virtual/widget/discount_cart.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Meu carrinho"),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 18),
              alignment: Alignment.center,
              child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
                  int p = model.products.length;

                  return Text(
                    "${p ?? 0} ${p == 1 ? "item" : "itens"}", 
                    style: TextStyle(fontSize: 17),
                  );
                },
              ),
            )
          ],
        ),
        body: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            bool usuarioLogado = UserModel.of(context).isLoggedIn();
            if(model.isLoadding && usuarioLogado) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(!usuarioLogado) {
              return Container(
                padding: EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove_shopping_cart_outlined, size: 100, color: Theme.of(context).primaryColor,),
                    SizedBox(height: 20),
                    Text("Faça login para adicionar/visualizar seus produtos!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      child: Text("Entrar",
                        style: TextStyle(fontSize: 18, color: Colors.white),),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                        },
                    ),
                  ],
                ),
              );
            }
            else if(model.products == null || model.products.length == 0) {
              return Container(
                padding: EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text("Nenhum produto no carrinho", 
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),
                    SizedBox(height: 20),
                    // RaisedButton(
                    //   child: Text("Adicione produtos",
                    //     style: TextStyle(fontSize: 18, color: Colors.white),),
                    //     color: Theme.of(context).primaryColor,
                    //     onPressed: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => Categorytile()));
                    //     },
                    // ),
                  ],
                ),
              );
            }
            else {
              return ListView(
                children: [
                  Column(
                    children: model.products.map((product) {
                      return CartTile(cartProduct: product);
                    }
                   ).toList(),
                  ),
                  Discountcart()
                ],
              );
            }
          },
        ),
    );
  }
}