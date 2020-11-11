import 'package:flutter/material.dart';
import 'package:user_preferences/src/user_preferences/user_preferences.dart';
import 'package:user_preferences/src/widgets/menu_widget.dart';      

class PreferencesPage extends StatefulWidget {

  static final String routeName = 'preferences';
  
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {

 final _prefs = new UserPreferences();

  bool _colorSecundario;
  int _genero;
  String _nombre;

  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    _colorSecundario = _prefs.colorSecundario;
    _genero = _prefs.genero;
    _nombre = _prefs.nombreUsuario;
    textEditingController = new TextEditingController(text: _nombre);
    _prefs.lastPage = PreferencesPage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _prefs.colorSecundario ? Colors.orange : Colors.blue,
        title: Text('Preferencias'),
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[

          Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              'Settings', 
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
          ),

          Divider(),

          SwitchListTile(
            title: Text('Color Secundario'),
            value: _colorSecundario, 
            onChanged: ( value ){
              setState(() {
                _colorSecundario = value;
                _prefs.colorSecundario = value;
              });

          }),

          RadioListTile(
            title: Text('Masculino'),
            value: 1, 
            groupValue: _genero, 
            onChanged: ( value ){
              setState(() { 
                _prefs.genero = value;
                _genero = value;
              });
            }),

          RadioListTile(
            title: Text('Femenino'),
            value: 2, 
            groupValue: _genero, 
            onChanged: ( value ){
              setState(() { 
                _prefs.genero = value;
                _genero = value;
              });
            }),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: 'Usuario', 
                  helperText: 'Nombre de usuario que utiliza la app.',
                ),
                onChanged: ( value ) {
                  _prefs.nombreUsuario = value;

                },
              ),
            )
        ],
      ),
    );
  }
}