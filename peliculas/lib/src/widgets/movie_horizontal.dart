import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:uuid/uuid.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  MovieHorizontal({ 
    @required this.peliculas, 
    @required this.siguientePagina
  });

  @override
  Widget build(BuildContext context) {

    final pageSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -200)
      {
        siguientePagina();
      }
    });

    return Container(
      height: pageSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return crearTarjeta(peliculas[i], context);
        },
      ),
      
    );
  }

  Widget crearTarjeta(Pelicula pelicula, context) {

    pelicula.uniqueId = new Uuid().v4().toString();

    final tarjeta =  Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
            )
        ],
      ),
    );
        
    return GestureDetector(
      child: tarjeta, 
      onTap: (){
       Navigator.pushNamed(context, 'detalle', arguments: pelicula);
    });

  }

}