import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(1.0),
            child: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('https://pm1.narvii.com/6334/d035f29b7561ff523c6b6842a1184062e22cc67c_hq.jpg'),
              ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: 
            CircleAvatar(
              child: Text('FM'),
              backgroundColor: Colors.deepPurple,
            )
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/original.gif'), 
          image: NetworkImage('https://pm1.narvii.com/6334/d035f29b7561ff523c6b6842a1184062e22cc67c_hq.jpg'),),),
    );
  }
}