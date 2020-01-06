import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumApiBloc();

  @override
  void initState() {
    super.initState();
    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.carro.nome),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.place),
              onPressed: _onClickMapa,
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: _onClickVideo,
            ),
            PopupMenuButton<String>(
              onSelected: _onClickPopupMenu,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'Editar',
                    child: Text('Editar'),
                  ),
                  PopupMenuItem(
                    value: 'Deletar',
                    child: Text('Deletar'),
                  ),
                  PopupMenuItem(
                    value: 'Share',
                    child: Text('Share'),
                  )
                ];
              },
            )
          ],
        ),
        body: _body());
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Image.network(widget.carro.urlFoto),
            _bloco1(),
            Divider(),
            _bloco2(),
          ],
        ));
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.carro.nome, fontSize: 20, bold: true),
            text(widget.carro.tipo, fontSize: 16)
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickShare,
            )
          ],
        ),
      ],
    );
  }

  _bloco2() {
    Future<String> future = LoripsumApi.getLoripsum();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text(widget.carro.descricao, fontSize: 16),
          SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: _loripsumApiBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Text(snapshot.data);
            },
          ),
          text("sssssssssssssssssss")
        ]);
  }

  void _onClickMapa() {
    print('Clicou no mapa');
  }

  void _onClickVideo() {
    print('Clicou no video');
  }

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        break;
      case "Deletar":
        break;
      case "Shared":
        break;
    }
  }

  void _onClickFavorito() {}

  void _onClickShare() {}
}
