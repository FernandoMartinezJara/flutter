import 'package:flutter/material.dart';
import 'package:qrscan/src/pages/home_page.dart';
import 'package:qrscan/src/pages/mapa_page.dart';
import 'package:qrscan/src/pages/mapas_page.dart';
import 'package:qrscan/src/pages/ruta_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mapas' : (BuildContext context) => MapasPage(),
        'ruta' : (BuildContext context) => RutaPage(),
        'mapa' : (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}