import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class _MenuProvider{

  List<dynamic> opciones = [];

  Future<List<dynamic>> cargarData() async {

    var data = await rootBundle.loadString('data/menu_opts.json');

    Map dataMap = json.decode(data);

    opciones = dataMap['rutas'];

    return opciones;

  }
  
}

final menuProvider = new _MenuProvider();