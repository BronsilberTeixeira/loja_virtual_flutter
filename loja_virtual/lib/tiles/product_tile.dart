import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/products_data.dart';
import 'package:loja_virtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData productData;

  const ProductTile(this.type, this.productData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(productData))
        );
      },
      child: Card(
        child: type == "grid" ? 
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                productData.images[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget >[
                    Text(productData.title, 
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text("R\$ ${productData.price.toStringAsFixed(2)}", 
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ) 
        : Row(
          children: [
            Flexible(
              flex: 1,
              child: Image.network(
                productData.images[0],
                fit: BoxFit.cover,
                height: 200,
              )
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget >[
                    Text(productData.title, 
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text("R\$ ${productData.price.toStringAsFixed(2)}", 
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}