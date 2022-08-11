
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/cadastrar_screen.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.grey
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}
