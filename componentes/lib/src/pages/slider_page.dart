import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double sliderSelect = 250.0;
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Slider Page')),
      body: Column(
        children: <Widget>[
          _addFadeImage(),
          Divider(),
          _addSlider(),
          Divider(),
          _addChecboxTile(),
          Divider(),
          _addSwitchboxTile()
        ],
      ),
    );
  }

  Widget _addFadeImage(){
   return Expanded(
      child: 
        FadeInImage(
          width: sliderSelect,
          placeholder: AssetImage('assets/original.gif'), 
          image: NetworkImage('https://1.bp.blogspot.com/-8bEp3Ugtthc/Xq80Zmvbc3I/AAAAAAAANFA/9SwR_kZ6rXU989wuUwGEKxy3bliwTDtQQCLcBGAsYHQ/w1200-h630-p-k-no-nu/Album_Cover.jpg')
        )
    );

  }

  _addSlider() {
    return Slider(
      value: sliderSelect,
      max: 500.0,
      min: 0, 
      onChanged: isEnabled ? (value){
        setState(() {
          sliderSelect = value;
        });
      } : null
      );
  }

  _addChecboxTile() {
    return CheckboxListTile(
      value: isEnabled,
      title: Text('Habilitar Sliders'), 
      onChanged: (value){
        setState(() {
          isEnabled = value;
        });
      });
  }

  _addSwitchboxTile() {
    return SwitchListTile(
      value: isEnabled,
      title: Text('Habilitar Sliders'), 
      onChanged: (value){
        setState(() {
          isEnabled = value;
        });
      });
  }

}