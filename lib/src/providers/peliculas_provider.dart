import 'dart:convert';
import 'package:flutterappramsolpeliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;


class PeliculasProvider{

  String _apikey = '84dcb99f3105246925c2d9c4b6654e20';
  String _url = 'api.themoviedb.org';
  String _languaje= 'es-ES';

  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language': _languaje
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);


    //print(resp);
    //print( decodedData['results'] );


//convierte el json a objetos de peliculas para que podamos manejar cada pelicula
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    //print(peliculas.items[5].title);

    return peliculas.items;
  }//final del Future


  Future <List<Pelicula>> getPopulares() async{
    
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language': _languaje
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
    
  } 


}