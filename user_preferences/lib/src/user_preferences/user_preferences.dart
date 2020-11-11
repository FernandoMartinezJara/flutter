

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_preferences/src/pages/home_page.dart';

class UserPreferences{

  static final UserPreferences _instance = new UserPreferences.internal();
  
  factory UserPreferences()
  {
    return _instance;
  }

  UserPreferences.internal();


  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Getter & Setter Color Secundario
  get colorSecundario
  {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario ( bool value ){
    _prefs.setBool('colorSecundario', value);
  }

  //Getter & Setter genero
  get genero
  {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero ( int value ){
    _prefs.setInt('genero', value);
  }

  //Getter & Setter Nombre 
  get nombreUsuario
  {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario ( String value ){
    _prefs.setString('nombreUsuario', value);
  }

    //Getter & Setter Nombre 
  get lastPage
  {
    return _prefs.getString('lastPage') ?? HomePage.routeName;
  }

  set lastPage ( String value ){
    _prefs.setString('lastPage', value);
  }

}