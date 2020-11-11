import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          _crearAppbar(pelicula),

          SliverList(
            delegate: SliverChildListDelegate(<Widget>[

              SizedBox(height: 10.0,),
              _posterTitulo(pelicula, context),
              _descripcion(pelicula),
              _casting(pelicula)
            ])
            
            )
        ],
      )
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(
            color: Colors.white, 
            fontSize: 16.0),
          overflow: TextOverflow.ellipsis,),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'), 
          image: NetworkImage(pelicula.getBackgroundImg()),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 500),
          ),
          
      ),
    
    );

  }

  _posterTitulo(Pelicula pelicula, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  pelicula.title, 
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis),
                Text(
                  pelicula.originalTitle, 
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis),
                Row(children: <Widget>[
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString())
                ] ,)
              ],
            ))
        ],
      ),


    );
  }

 Widget _descripcion(Pelicula pelicula) {

   return Container(
     padding: EdgeInsets.symmetric(
       vertical: 20.0, 
       horizontal: 20.0),
     child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify),);
 }

  Widget _casting(Pelicula pelicula) {

    var peliculaProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliculaProvider.getCasts(pelicula.id),
      builder: (context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){
          return _crearCastPageView(snapshot.data,context);
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      });

  }

  Widget _crearCastPageView(List<Actor> actores, context) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        itemCount: actores.length,
        itemBuilder: (context, i){
         return _createActorTarjeta(actores[i]);
        },
      )

    );

  }

  Widget _createActorTarjeta(Actor actor) {

    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'), 
              image: NetworkImage(actor.getPhoto()),
              height: 150.0,
              fit: BoxFit.cover),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

  }


}