import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page')
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Mostrar Alerta'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () => mostrarAlerta(context),
          shape: StadiumBorder()
          ,) 
        ,),
    );
  }

void mostrarAlerta(BuildContext context)
{
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text('Titulo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Contenido de la alerta.'),
            FlutterLogo(size: 100.0,),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Cancelar')),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Aceptar'))
        ]);
    }
  );
}

}