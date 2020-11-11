import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {

  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.pink;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Animated Container'),
       ),
       body: Center(
         child: AnimatedContainer(
           width: _width,
           height: _height,
           decoration: BoxDecoration(
             borderRadius: _borderRadius,
             color: _color
           ), 
           duration: Duration(seconds: 1),
           curve: Curves.bounceOut,
         ),
       ),
      floatingActionButton: FloatingActionButton(
         onPressed: changeShape,
         child: Icon(Icons.play_arrow),
      )
    );
  }

  void changeShape() {

    setState(() {
      _height= Random().nextInt(300).toDouble();
      _width = Random().nextInt(300).toDouble();
      _color = Color.fromRGBO(
        Random().nextInt(255), 
        Random().nextInt(255), 
        Random().nextInt(255), 
        1);
    });
  }
}