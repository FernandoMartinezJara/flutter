import 'package:componentes/src/utils/icono_string_util.dart';
import 'package:flutter/material.dart';
import 'package:componentes/src/providers/menu_provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('titulo')),
      body: _lista()
      
    );
  }

  Widget _lista()
  {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

        return ListView(
          children: _getItems(snapshot.data, context),
        );
      },
    );

  }

  List<Widget>_getItems(List<dynamic> menuItems, BuildContext context) {
    
    List<Widget> menuOpts = [];

    menuItems.forEach((element) {

      final listTile = ListTile(
        title: Text(element['texto']),
        leading: getIcon(element['icon']),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: (){
          
          Navigator.pushNamed(context, element['ruta']);
          
        },

      );
      
      menuOpts..add(listTile)
              ..add(Divider());
    });

    return menuOpts;

  }

}