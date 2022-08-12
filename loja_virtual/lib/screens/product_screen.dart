import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/products_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData productData;

  ProductScreen(this.productData);

  @override
  State<ProductScreen> createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  String size;

  final ProductData productData;
  _ProductScreenState(this.productData);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            productData.title,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                images: productData.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 5.0,
                dotSpacing: 10,
                dotBgColor: Color.fromARGB(50, 255, 255, 255),
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    productData.title,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    maxLines: 3,
                  ),
                  Text(
                    "R\$ ${productData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Tamanho",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 35,
                    child: GridView(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.5),
                      children: productData.sizes.map((s) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              size = s;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: s == size
                                        ? Colors.blue[400]
                                        : primaryColor,
                                    width: 2)),
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              s,
                              style: TextStyle(
                                  color: s == size
                                      ? Colors.blue[400]
                                      : primaryColor),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 45,
                    child: RaisedButton(
                      onPressed: size != null
                          ? () {
                              if (UserModel.of(context).isLoggedIn()) {
                                //adicionar ao carrinho
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              }
                            }
                          : null,
                      child: Text(
                        UserModel.of(context).isLoggedIn()
                            ? 'Adicionar ao carrinho'
                            : 'Entre para comprar',
                        style: TextStyle(
                            fontSize: 18,
                            color: size != null
                                ? Colors.blue[400]
                                : Colors.grey[400]),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
