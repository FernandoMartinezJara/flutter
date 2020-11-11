
import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscan/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

export 'package:qrscan/src/models/scan_model.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    if(_database != null) return _database;
    
    _database = await initDB();

    return _database;
  }

  initDB() async{

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final dbPath = join( documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async{
        
        await db.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT)'
        );
      });
  }

  addScanRaw(ScanModel scan) async {

    final db = await database;

    final _insert = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, value) "
      "VALUES (${scan.id}, '${scan.tipo}', '${scan.valor}¡)"
    );

    return _insert;
  }

  addScan(ScanModel scan) async {

    final db = await database;

    final _insert = await db.insert('Scans', scan.toJson());

    return _insert;
  }

  Future<ScanModel> getScanById(int id) async {

    final db = await database;

    final scan = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    
    return scan.isNotEmpty ? ScanModel.fromJson(scan.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async{

    final db = await database;

    final scans = await db.query('Scans');

    List<ScanModel> list = scans.isNotEmpty ?
      scans.map((c) => ScanModel.fromJson(c)).toList() :
      [];

      return list;
  }

  Future<List<ScanModel>> getScansByTipo(String tipo) async {

    final db = await database;

    final scans = await db.rawQuery("SELECT * FROM Scans WHERE tipo = '$tipo'");

    List<ScanModel> list = scans.isNotEmpty ? 
      scans.map((c) => ScanModel.fromJson(c)).toList() : 
      [];

    return list;

  }

  Future<int> updateScan(ScanModel scan) async{

    final db = await database;

    final _scan = await db.update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);

    return _scan;
  }

  Future<int> delete(int id) async {

    final db = await database;
    final scan = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return scan;
  }

  Future<int> deleteAll() async {

    final db = await database;
    final scan = await db.rawDelete('DELETE FROM Scans');
    return scan;
  }

}