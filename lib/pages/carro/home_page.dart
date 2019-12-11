import 'package:carros/drawer_list.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Usuario usuario;

  HomePage(this.usuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carros'),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Center(
      child: Text(
        'Olá ${usuario.nome}',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
