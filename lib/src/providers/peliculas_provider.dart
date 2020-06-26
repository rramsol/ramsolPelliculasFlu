import 'dart:async';
import 'dart:convert';
import 'package:flutterappramsolpeliculas/src/models/actores_model.dart';
import 'package:flutterappramsolpeliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;



class PeliculasProvider{
  bool _cargando = false;

  String _apikey = '84dcb99f3105246925c2d9c4b6654e20';
  String _url = 'api.themoviedb.org';
  String _languaje= 'es-ES';
  int _popularesPage = 0;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream <List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future <List<Pelicula>> _procesarRespuesta(Uri url) async{

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    //convierte el json a objetos de peliculas para que podamos manejar cada pelicula
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    //print(peliculas.items[5].title);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language': _languaje
    });

    return await _procesarRespuesta(url);
  }//final del Future

  Future <List<Pelicula>> getPopulares() async{

    if(_cargando ) return[];

    _cargando = true;

    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language': _languaje,
      'page'    : _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
    
  }

  Future <List<Actor>> getCast( String peliId )async{
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key' : _apikey,
      'language': _languaje
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromjsonList(decodedData['cast']);

    return cast.actores;


  }





}