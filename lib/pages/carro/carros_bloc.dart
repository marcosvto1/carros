import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/favoritos/carro_dao.dart';
import 'package:carros/utils/network.dart';

class CarrosBloc {
  final _streamController = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamController.stream;

  Future<List<Carro>> fetch(tipo) async {
    try {
      List<Carro> carros;

      bool networkOn = await isNetwordOn();

      if (!networkOn) {
        carros = await CarroDAO().findAllByTipo(tipo);
        _streamController.add(carros);
        return carros;
      }

      carros = await CarrosApi.getCarros(tipo);

      if (carros.isNotEmpty) {
        final dao = CarroDAO();

        // SALVAR TODOS OS CARROS
        carros.forEach(dao.save);
      }

      if (!_streamController.isClosed) {
        _streamController.add(carros);
        return carros;
      }
    } catch (e) {
      _streamController.addError(e);
    }
  }

  dispose() {
    _streamController.close();
  }
}
