import 'dart:convert';

import 'package:carros/pages/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<Usuario> login(String login, String senha) async {
    //var url = 'http://livrowebservices.com.br/rest/login';
    var url = 'http://carros-springboot.herokuapp.com/api/v2/login';

    Map params = {"username": login, "password": senha};

    String jsonParam = json.encode(params);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http.post(url, body: jsonParam, headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return Usuario(mapResponse['email'], mapResponse['senha']);
    }

    return null;
  }
}