import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class ProductsTap extends StatelessWidget {
  // const ProductsTap({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        else {

          var dividerTiles = ListTile.
          divideTiles(
            tiles: snapshot.data.documents.map(
              (doc){
                return Categorytile(doc);
              }
            ).toList(),
            color: Colors.grey
          ).toList();

          return ListView(
            children: dividerTiles
          );
        }
      }
    );
  }
}