import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {

  final tituloStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final subtituloStyle = TextStyle(fontSize: 16.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            _addImage(),
            _addTitulo(),
            _addActions(),
            _addText(),
            _addText(),
            _addText(),

          ],
        ),
      ),
    );
  }

  Widget _addImage(){
  return  Image(
      height: 250.0,
      width: double.infinity,
      fit: BoxFit.cover,
      image: 
        NetworkImage('https://i.vimeocdn.com/video/703876203_640.jpg'));

}
  
  Widget _addTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          children: <Widget>[
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lago con arboles', style: tituloStyle,),
                  SizedBox(height: 7.0),
                  Text('Este es un lago al sur del mundo', style: subtituloStyle)
                ],
              ),
            ),

            Icon(Icons.star, color: Colors.red),
            Text('41')

          ],
        ),
      ),
    );
  }

  Widget _addActions(){
    return Row(
      mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _action(Icons.call, 'CALL'),
        _action(Icons.near_me, 'NEAR ME'),
        _action(Icons.share, 'SHARE'),

      ],

    );
  }

  Widget _action(IconData iconData, String texto){
    return Column(
      children: <Widget>[
        Icon(
          iconData, 
          color: Colors.blue,
          size: 40.0,),

          SizedBox(height: 7.0,),
          
          Text(texto, style: TextStyle(color:Colors.blue))

      ],

    );
  }

  Widget _addText(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Text('Non tempor adipisicing aliquip anim aute. Incididunt incididunt esse et velit commodo proident eiusmod pariatur cupidatat et aute velit consequat. Incididunt eu laboris ipsum id duis. Labore veniam aliqua enim do reprehenderit. Aliqua dolor ut commodo veniam officia excepteur exercitation nisi eu esse consectetur cillum. Dolor cupidatat ullamco reprehenderit aliqua ut id eu reprehenderit eu quis occaecat qui sint cupidatat. Laborum ea culpa laborum cupidatat ullamco aliquip aliqua enim labore dolor velit deserunt sunt.',
        textAlign: TextAlign.justify,),
      ),
    );
  }

}