import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';

class PeliculasProvider {

  final _apiKey = 'fee6f8a8cb6f327c9aa7e279bee1f16e';
  final _url = 'api.themoviedb.org';
  final _language = 'es-ES';
  
  int _popularesPage = 1;
  bool _isLoading = false;
  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _getPeliculasApi(Uri url) async{
    final response = await http.get(url);
    final parseResponse = json.decode(response.body);
    final peliculas = new Peliculas.fromJsonList(parseResponse['results']);
    return peliculas.items;
  }  

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apiKey,
      'language' : _language
    });

    return await _getPeliculasApi(url);
  }

  ///Obtiene una lista de peliculas populares
  Future<List<Pelicula>> getPopulares() async {

    if(_isLoading) return [];

    _isLoading = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });

    var resp =  await _getPeliculasApi(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _isLoading = false;
    return resp;

  }

  Future<List<Actor>> getCasts(int movieId) async{

    final url = Uri.https(_url, '3/movie/$movieId/credits',
    {
      'api_key'  : _apiKey,
      'language' : _language,
    });

    var resp = await http.get(url);

    var respDecoded = json.decode(resp.body);

    final cast = new Cast.fromJsonList(respDecoded['cast']);
    return cast.actores;
  }

  Future<List<Pelicula>> searchPeliculas(String _query) async {

    final url = Uri.https(_url, '3/search/movie',{
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : _query
    });

    return await _getPeliculasApi(url);
  }

}
