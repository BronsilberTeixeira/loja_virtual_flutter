import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class Discountcart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800]
          ),
        ),
        leading: Icon(Icons.card_membership),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite o cupom de desconto"
              ),
              initialValue: CartModel.of(context).cupomCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance.collection("cupom").document(text).get().then((docSnap) {
                  if(docSnap.data != null) {
                     Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Desconto de ${docSnap.data["percent"]}% aplicado"),
                        backgroundColor: Theme.of(context).primaryColor,  
                      )
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cupon digitado não existe! tente Outro"),
                        backgroundColor: Colors.red[900],
                      )
                    );
                  }
                });
              },
            )  
          ),
        ],
      ),
    );
  }
}