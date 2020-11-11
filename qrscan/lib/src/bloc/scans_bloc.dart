import 'dart:async';

import 'package:qrscan/src/bloc/validator.dart';
import 'package:qrscan/src/provider/db_provider.dart';

class ScansBloc with Validator {

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }
  
  ScansBloc._internal(){
    getAllScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose(){
    _scansController?.close();
  }

  addScan(ScanModel scan) async{
    await DBProvider.db.addScan(scan);
    getAllScans();
  }

  getAllScans() async{
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  deleteScan(int id) async{
    await DBProvider.db.delete(id);
    getAllScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    getAllScans();
  }


}