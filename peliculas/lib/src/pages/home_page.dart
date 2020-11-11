import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final provider = new PeliculasProvider();
 
  @override
  Widget build(BuildContext context) {

    provider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        centerTitle: false,
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              showSearch(context: context, delegate: SearchData());
            })],
      ),
      body:Container(
        child: Column(
          children: <Widget>[
           _getSwiper(),
           _getFooter(context)
        ],
        )
      ) 
    );
  }

  Widget _getSwiper()
  {
    return FutureBuilder(
      future: provider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
      
      if(snapshot.hasData){
        return CardSwiper(peliculas: snapshot.data);
      }
      else{
        return Container(
          height: 500.0,
          child: Center(
            child: CircularProgressIndicator()),
        );
      }
      },
    );

    // return Text('wedw');
  }
  
  Widget _getFooter(context)
  {
     return Container(
       width: double.infinity,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           
           Container(
             margin: EdgeInsets.only(left: 20.0),
             child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)),

           SizedBox(height: 5.0,),
           
           StreamBuilder(
            stream: provider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
            
            if(snapshot.hasData){
              return Container(
                height: 200.0,
                child: MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: provider.getPopulares,));
            }
            else{
              return Container(
                height: 100.0,
                child: Center(
                  child: CircularProgressIndicator()),
              );
            }
            },
          )
         ],
       ),
     );
  }

}