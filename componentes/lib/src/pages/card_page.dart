import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
           getCardTipo1(),
           SizedBox(height: 30.0),
           getCardTipo2()
        ],
      ),
    );
  }
           
  getCardTipo1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child:
        Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.all_inclusive),
              title: Text('Card Title'),
              subtitle: Text('Este es el subtitulo del card.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: (){}, 
                  child: Text('Cancelar')),
                FlatButton(
                  onPressed: (){}, 
                  child: Text('Aceptar')
              ),
          ]
        )
          ]          
        ),
      );
  }

  getCardTipo2() {
    final card = Card(
      clipBehavior: Clip.antiAlias,
      child: 
        Column(
          children: <Widget>[

            FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: Duration( milliseconds: 200),
              height: 250.0,
              placeholder: AssetImage('assets/original.gif'), 
              image: NetworkImage('https://images.unsplash.com/photo-1500964757637-c85e8a162699?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb')
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Caligula`s Horse New Album'),
            )
          ],
        ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: card
      ),
    );
  }
}