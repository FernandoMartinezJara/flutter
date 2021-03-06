import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:uuid/uuid.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
        height: 500.0,
        padding: EdgeInsets.only(top:10.0),
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context, int index){
             
             peliculas[index].uniqueId = new Uuid().v4().toString();
            
            return Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover
                    ),
                  onTap: (){
                    Navigator.pushNamed(context, 'detalle', arguments : peliculas[index]);
                  },
                )
              ),
            );
          },
          itemCount: peliculas.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
          ),
      );

  }
}