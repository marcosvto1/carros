import 'package:carros/pages/home_page.dart';
import 'package:carros/pages/login_api.dart';
import 'package:carros/pages/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  var _tLogin = TextEditingController();

  var _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Carros'),
        ),
        body: _body());
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(children: <Widget>[
          AppText('Login', 'Digite o login',
              controller: _tLogin,
              validator: _validationLogin,
              textInputAction: TextInputAction.next,
              focusNext: _focusSenha),
          SizedBox(
            height: 15,
          ),
          AppText(
            'Senha',
            'Digite a Senha',
            password: true,
            controller: _tSenha,
            validator: _validationSenha,
            keyboardType: TextInputType.number,
            focusNode: _focusSenha,
          ),
          SizedBox(
            height: 29,
          ),
          AppButton("Login", onPressed: _onClickLogin),
        ]),
      ),
    );
  }

  String _validationLogin(String text) {
    if (text.isEmpty) {
      return 'Digite o login';
    }
    return null;
  }

  String _validationSenha(String text) {
    if (text.isEmpty) {
      return 'Digite a Senha';
    }
    if (text.length < 2) {
      return 'A senha precisa ter pelo menos 3 números';
    }
    return null;
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    Usuario usuario = await LoginApi.login(login, senha);
    if (usuario != null) {
      push(context, HomePage());
    } else {
      print('Login incorreto');
    }
  }
}
