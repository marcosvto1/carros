import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
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
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    Future<Usuario> usuario = Usuario.get();
    usuario.then((Usuario usuario) {
      if (usuario != null) {
        push(context, HomePage(), replace: true);
      }
    });
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
          AppButton(
            "Login",
            onPressed: _onClickLogin,
            showProgress: _showProgress,
          ),
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
    setState(() {
      _showProgress = true;
    });
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse response = await LoginApi.login(login, senha);

    if (response.ok) {
      Usuario usuario = response.result;
      push(context, HomePage());
    } else {
      alert(context, response.msg, 'Login');
    }

    setState(() {
      _showProgress = false;
    });
  }
}
