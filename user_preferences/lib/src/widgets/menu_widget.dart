import 'package:flutter/material.dart';
import 'package:user_preferences/src/pages/home_page.dart';
import 'package:user_preferences/src/pages/preferences_page.dart';
  
class MenuWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/menu-header.jpg')),               
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              },
            ),

              ListTile(
              leading: Icon(Icons.settings),
              title: Text('Preferences'),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, PreferencesPage.routeName);
              },
            ),

          ],
        ),
      );
    }
}
