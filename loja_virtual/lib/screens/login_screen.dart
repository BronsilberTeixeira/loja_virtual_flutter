import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/cadastrar_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import '';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool verSenha = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Entrar",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            FlatButton(
              child: Text(
                "Criar conta",
                style: TextStyle(fontSize: 16),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CadastrarScreen()));
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModal>(
          builder: (context, child, model) {
            if(model.isLoading) return Center(child: CircularProgressIndicator());
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "E-mail",
                          icon: Icon(Icons.mail_outline_rounded)),
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
                                hintText: "Senha",
                                icon: Icon(Icons.lock_outlined)),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        color: Colors.grey[500],
                        onPressed: () {
                          if (_formKey.currentState.validate()) {}

                          model.signIn();
                        },
                      ),
                    )
                  ],
                ));
          },
        ));
  }
}
