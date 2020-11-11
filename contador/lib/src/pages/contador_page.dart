import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget{
 
 @override
 createState() =>  _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {

  final _estiloTexto = new TextStyle(fontSize: 25.0);
  int _conteo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo Stateful'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Numero de Taps: ',
              style: _estiloTexto),
            Text(
              '$_conteo',
              style: _estiloTexto)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: GetBotones(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget GetBotones()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end ,
      children: <Widget>[

        SizedBox(width: 30),

        FloatingActionButton(
          onPressed: _reset,
          child: Icon(Icons.exposure_zero),
        ), 
        
        Expanded(child: SizedBox()),
        
        FloatingActionButton(
          onPressed: _sustraer,
          child: Icon(Icons.remove),
        ), 

        SizedBox(width: 5.0),

        FloatingActionButton(
          onPressed: _agregar,
          child: Icon(Icons.add),
        ), 

      ],
    );
  }

  void _agregar(){
    setState(() => _conteo ++);
  }

  void _sustraer(){
    setState(() => _conteo --);
  }

  void _reset(){
    setState(() => _conteo = 0);
  }

}