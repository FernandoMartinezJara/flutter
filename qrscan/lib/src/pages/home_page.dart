import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/src/bloc/scans_bloc.dart';
import 'package:qrscan/src/models/scan_model.dart';
import 'package:qrscan/src/pages/ruta_page.dart';
import 'package:qrscan/src/utils/utils.dart';

import 'mapas_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QrScan'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: (){ 
              scansBloc.deleteAllScans();
            }
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
           _scan(context);
        },
        child: Icon(Icons.my_location),),
    );
  }

  _scan(BuildContext context) async{

    ScanResult futureString;
    
    try{
      futureString = await BarcodeScanner.scan();
    }
    catch(e){
      print(e.toString());
    }
    
    print('future string :' + futureString.rawContent);
 
    if(futureString!=null){
      print('teenemosinformacion');
    }

    if ( futureString != null &&  futureString.rawContent != '') {
      
      final scan = ScanModel( valor: futureString.rawContent );
      scansBloc.addScan(scan);      

      if ( Platform.isIOS ) {
          Future.delayed( Duration( milliseconds: 750 ), () {
          openScan(context, scan);    
        });
      } else {
         openScan(context, scan);
      }
    }
  }

  Widget _callPage(int paginaActual)
  {
    switch (paginaActual) {
      case 0: return MapasPage();
      case 1: return RutaPage();
      default: return MapasPage();
    }
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapa')),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Rutas')),


    ]);

  }
}