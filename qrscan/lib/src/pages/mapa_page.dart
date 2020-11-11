import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:qrscan/src/bloc/scans_bloc.dart';
import 'package:qrscan/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final mapController = new MapController();
  String tipoMapa = 'streets';

  final scanBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){

              mapController.move(scan.getLatLon(), 15);

            })
        ],
      ),
      body: _addFlutterMap(scan),
      floatingActionButton: _addFloatingButton(context),
    );
  }

  Widget _addFloatingButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        print(tipoMapa);
        if(tipoMapa == 'streets'){
          tipoMapa = 'dark';
        }
        else if(tipoMapa == 'dark'){
          tipoMapa = 'light';
        }
        else if(tipoMapa == 'light'){
          tipoMapa = 'outdoors';
        }
        else if(tipoMapa == 'outdoors'){
          tipoMapa = 'satellite';
        }
        else{
          tipoMapa = 'streets';
        }
        
        setState(() {          
        });

      });
  }

  Widget _addFlutterMap(ScanModel scan){

    return Container(
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: scan.getLatLon(),
          zoom: 10
        ),
        layers: [
          _drawMap(),
          _addMarkers(scan)
        ],

      ),
    );
    
  }

  _drawMap()
  {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
        'id': 'mapbox.$tipoMapa'
      }
    );
  }

  _addMarkers(ScanModel scan){

    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLon(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor)
          ),

        )
      ]
    );
  }
}