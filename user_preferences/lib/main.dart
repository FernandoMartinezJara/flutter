import 'package:flutter/material.dart';
import 'package:user_preferences/src/pages/home_page.dart';
import 'package:user_preferences/src/pages/preferences_page.dart';
import 'package:user_preferences/src/user_preferences/user_preferences.dart';
 
final _prefs = new UserPreferences();
void main() async { 

  WidgetsFlutterBinding.ensureInitialized();

  await _prefs.initPrefs();

  runApp(MyApp());
  }
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preferencias de Usuario',
      initialRoute: _prefs.lastPage,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        PreferencesPage.routeName : (BuildContext context) => PreferencesPage()
      },
    );
  }
}