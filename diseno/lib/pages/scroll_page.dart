import 'package:flutter/material.dart';


class ScrollPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        pageSnapping: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _pagina1(),
          _pagina2()
        ],
      ),
    );
  }

  Widget _pagina1() {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imagen(),
        _textos()

      ],
    );
  }

  Widget _colorFondo(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108,192,218, 1),

    );
  }

  Widget _imagen() {
    return Image(
      fit: BoxFit.cover,
      image: AssetImage('assets/img/back.png'));
  }

  Widget _textos() {

    final textStyle = TextStyle(color: Colors.white, fontSize: 60.0);

    return SafeArea(
      child: Column(
        children: <Widget>[
          Text('11º', style: textStyle,),
          Text('Miercoles', style: textStyle,),
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 70.0,)
        ],
      ),
    );
  }

  Widget _pagina2() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 1.0),
      child:Center(
        child: RaisedButton(
          shape: StadiumBorder(),
          color: Colors.blue,
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:40.0),
            child: Text('Siguiente')),
          onPressed: () {}),
      ),
    );
  }
}