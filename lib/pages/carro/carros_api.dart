import 'dart:convert';

import 'package:carros/pages/login/usuario.dart';

import 'carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario usuario = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}"
    };

    var url = 'http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    String jsonResponse = response.body;
    print('status code:  ${response.statusCode}');

    try {
      List mapResponse = json.decode(jsonResponse);

      List<Carro> carros =
          mapResponse.map<Carro>((map) => Carro.fromJson(map)).toList();

      return carros;
    } catch (error, exception) {
      print("$error > $exception");
      throw error;
    }
  }
}
