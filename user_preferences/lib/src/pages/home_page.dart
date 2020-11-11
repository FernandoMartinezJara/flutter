import 'package:flutter/material.dart';
import 'package:user_preferences/src/user_preferences/user_preferences.dart';
import 'package:user_preferences/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {

  static final String routeName = 'home';
  
  @override
  Widget build(BuildContext context) {

    final _prefs = new UserPreferences();
    _prefs.lastPage = HomePage.routeName;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _prefs.colorSecundario ? Colors.orange : Colors.blue,
        title: Text('Home Page'),
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color Secundario: ${_prefs.colorSecundario}'),
          Divider(),
          Text('Género ${_prefs.genero}'),
          Divider(),
          Text('Nombre de usuario: ${_prefs.nombreUsuario}'),
          Divider(),
        ],
      ),
    );
  }
}