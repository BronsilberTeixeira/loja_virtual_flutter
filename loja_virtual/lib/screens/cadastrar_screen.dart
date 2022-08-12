import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastrarScreen extends StatefulWidget {
  // const CadastrarScreen({ Key? key }) : super(key: key);

  @override
  State<CadastrarScreen> createState() => _CadastrarScreenState();
}

class _CadastrarScreenState extends State<CadastrarScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _enderecoController = TextEditingController();

  bool verSenha = true;
  final _formKey = GlobalKey<FormState>();
  final _scafolfKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scafolfKey,
        appBar: AppBar(
          title: Text(
            "Criar conta",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if(model.isLoading) return Center(child: CircularProgressIndicator());
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: "Nome",
                          icon: Icon(Icons.account_circle_outlined)),
                      validator: (text) {
                        if (text.isEmpty || text.length < 3)
                          return "Nome Invalido!";
                      },
                    ),
                    SizedBox(height: 16),
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
                    TextFormField(
                      controller: _enderecoController,
                      decoration: InputDecoration(
                          hintText: "Endereço", icon: Icon(Icons.map_outlined)),
                      validator: (text) {
                        if (text.isEmpty) return "Endereço Invalido!";
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
                          if (_formKey.currentState.validate()) {

                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "endereco": _enderecoController.text
                            };
                              print(userData);
                           model.signUp(
                              userData, 
                              _senhaController.text, 
                              _onSuccess, 
                              _onFail
                            );
                          }
                        },
                      ),
                    )
                  ],
                ));
          },
        ));
  }

  void _onSuccess() {
    _scafolfKey.currentState.showSnackBar(
      SnackBar(content: Text('Usuario Criado com sucesso'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 4),
      )
    );
    Future.delayed(Duration(seconds: 4)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scafolfKey.currentState.showSnackBar(
      SnackBar(content: Text('Falha ao criar usuario, tente novamente mais tarde !'),
        backgroundColor: Colors.red[900],
        duration: Duration(seconds: 4),
      )
    );
  }
}
