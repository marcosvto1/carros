import 'package:flutter/material.dart';

alert(BuildContext context, String msg, [String title]) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? 'Carros'),
          content: Text('$msg'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                print('ok');
              },
            )
          ],
        );
      });
}
