import 'dart:async';

import 'package:qrscan/src/models/scan_model.dart';

class Validator {


  final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (data, sink) {
      final geoScans = data.where((s) => s.tipo == 'geo').toList();
      sink.add(geoScans);
    }
  );

  final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (data, sink) {
      final geoHttp = data.where((s) => s.tipo == 'http').toList();
      sink.add(geoHttp);
    }
  );
  
}