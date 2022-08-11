import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/login_screen.dart';

class CadastrarScreen extends StatefulWidget {
  // const CadastrarScreen({ Key? key }) : super(key: key);

  @override
  State<CadastrarScreen> createState() => _CadastrarScreenState();
}

class _CadastrarScreenState extends State<CadastrarScreen> {
  bool verSenha = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Criar conta",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Nome",
                    icon: Icon(Icons.account_circle_outlined)),
                validator: (text) {
                  if (text.isEmpty || text.length < 3) return "Nome Invalido!";
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "E-mail", icon: Icon(Icons.mail_outline_rounded)),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty || !text.contains('@'))
                    return "E-mail Invalido!";
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Senha", icon: Icon(Icons.lock_outlined)),
                      obscureText: verSenha,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha invalida!";
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          verSenha = !verSenha;
                        });
                      },
                      child: Icon(verSenha
                          ? Icons.remove_red_eye
                          : Icons.visibility_off_outlined),
                      padding: EdgeInsets.only(top: 40),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Endereço", icon: Icon(Icons.map_outlined)),
                validator: (text) {
                  if (text.isEmpty)
                    return "Endereço Invalido!";
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "Criar conta",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.grey[500],
                  onPressed: () {
                    if (_formKey.currentState.validate()) {}
                  },
                ),
              )
            ],
          )),
    );
  }
}
