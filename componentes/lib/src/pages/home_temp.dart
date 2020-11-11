import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  HomePageTemp({Key key}) : super(key: key);

  final items = ['Item 1','Item 2','Item 3','Item 4','Item 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes App'),
      ),
      body: ListView(
        children: _crearItemsV2()
      ),
    );
  }


  // List<Widget> _crearItems()
  // {
  //   List<Widget> _items = List<Widget>();

  //   for (var item in items) {
      

  //     var listTile = new ListTile(
  //       title: Text(item),
  //     );

  //     _items..add(listTile)
  //           ..add(Divider());

  //   }

  //   return _items;
  // }

  List<Widget> _crearItemsV2(){

   var widgets = items.map((item)
    {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('$item !'),
              subtitle: Text('Cualquier cosa'),
              trailing: Icon(Icons.arrow_right),
              onTap: (){},
            ),
            Divider()
          ],
        );

    }).
    toList();
  
    return widgets;
  }

}