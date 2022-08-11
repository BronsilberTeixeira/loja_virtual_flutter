import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

      Widget _builderDrawerback() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255,28,28,28),
            Color.fromARGB(255,192,192,192)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );

    return Drawer(
      child: Stack(
        children: [
          _builderDrawerback(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Clothing\nStore", 
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child:ScopedModelDescendant<UserModal>(
                        builder: (context, child, model) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Olá,${model.isLoggedIn() ? model.userData['name'] : ''}",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                    "Entre ou cadastre-se ->" :
                                    "sair",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold 
                                  ),
                                ),
                                onTap: () {
                                  if(!model.isLoggedIn()) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => LoginScreen())
                                    );
                                    return;
                                  }
                                  model.signOut();
                            
                                },
                            )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on_outlined, "Encontre uma loja", pageController, 2),
              DrawerTile(Icons.playlist_add_check_outlined, "Meus pedidos", pageController, 3)
            ],
          )
        ],
      ),
    );
  }
}