

import 'dart:async';

import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  
  List<int> _listaNumeros = [1,2,3,4,5];
  int _ultimoItem = 0;
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addItems(10);

    _scrollController.addListener(() {
      //Calculo para verificar el final del listview
      if(_scrollController.position.pixels == 
      _scrollController.position.maxScrollExtent){
        // _addItems(10);
        _fetchData();
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Page')
      ),
      body: Stack(
        children: <Widget>[
          _addListView(),
          _addLoading()
        ],
      )
    
    );
  }

  Widget _addListView() {

    return RefreshIndicator(
      onRefresh: _getFirstPage,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listaNumeros.length,
        itemBuilder: (BuildContext context, int index){

          final imagen = _listaNumeros[index];

          return FadeInImage(
            placeholder: AssetImage('assets/original.gif'), 
            image: NetworkImage('https://picsum.photos/500/300/?image=$imagen'));

        }
      ),
    );

  }

    Future _getFirstPage() async {
    
    final _duration = new Duration(seconds: 2);
     await new Timer(_duration, (){
       _listaNumeros.clear();
       _ultimoItem++;
       _addItems(10);
     });
    return Future.delayed(_duration);
  }

  void _addItems(int itemsCount)
  {
    for (var i = 0; i < itemsCount; i++) {
      _ultimoItem++;
      _listaNumeros.add(_ultimoItem);
    }
    setState(() {
      
    });
  }

  Future _fetchData() async {

    _isLoading = true;
    setState(() {
      
    });
    
    final _duration = new Duration(seconds: 2);
    return new Timer(_duration, _respuestaHttp);
    
  }
  
  void _respuestaHttp() {
    _isLoading = false;
    _scrollController.animateTo(
        _scrollController.position.pixels +100, 
        duration: Duration(microseconds: 250), 
        curve: Curves.fastOutSlowIn);
    _addItems(10);
  }

 Widget _addLoading() {
   if(_isLoading){
     return Column(
       mainAxisAlignment: MainAxisAlignment.end,
       mainAxisSize: MainAxisSize.max,
       children: <Widget>[
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             CircularProgressIndicator(),
           ],
         ),
         SizedBox(height: 15.0,)
       ],
     );
   }
   else{
     return Container();
   }
 }
}