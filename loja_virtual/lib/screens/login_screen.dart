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
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool verSenha = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator());
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    TextFormField(
                      controller: _emailController,
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
                            controller: _senhaController,
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
                        onPressed: () {
                          if (_emailController.text.isEmpty) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text('Insira o e-mail de recuperação'),
                              backgroundColor: Colors.red[900],
                              duration: Duration(seconds: 4),
                            ));
                          } else {
                            model.recoverPass(_emailController.text);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  'Confira seu e-mail'),
                              backgroundColor: Theme.of(context).primaryColor,
                              duration: Duration(seconds: 4),
                            ));
                          }
                        },
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

                          model.signIn(_emailController.text,
                              _senhaController.text, _onSuccess, _onFail);
                        },
                      ),
                    )
                  ],
                ));
          },
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Usuario logado com sucesso'),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 4),
    ));
    Future.delayed(Duration(seconds: 1)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Falha ao Entrar com usuario, tente outro !'),
      backgroundColor: Colors.red[900],
      duration: Duration(seconds: 4),
    ));
  }
}
