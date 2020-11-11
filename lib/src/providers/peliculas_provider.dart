import 'package:movies_app/src/models/actores_model.dart';
import 'package:movies_app/src/models/pelicula_model.dart';

import 'dart:convert';
import 'dart:async';
// Http
import 'package:http/http.dart' as http;

// TODO API REST
class PeliculasProvider {
  String _apiKey = 'apiKey';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  // TODO Stream
  List<Pelicula> _populares = new List();
  // Instancia del Stream
  // Broadcast permite que se utilice este Stream para varias llamadas
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  // Agrega peliculas al Stream
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  // Observable las peliculas agregados
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }
  // TODO Fin Stream

  Future<List<Pelicula>> _procesarRes(Uri url) async {
    final res = await http.get(url);
    // Transforma la res en un Map
    final decodedData = json.decode(res.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    //print(peliculas.items[0].title);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    // Genera la url
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _languaje,
    });

    return await _procesarRes(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    // Si esta cargando datos no retorna nada
    if (_cargando) return [];

    _cargando = true;

    // Control paginacion
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _languaje,
      'page': _popularesPage.toString(),
    });

    // Respuesta asincrona
    final res = await _procesarRes(url);

    // Agrega la lista de peliculas al stream
    _populares.addAll(res);
    popularesSink(_populares);

    _cargando = false;

    return res;
  }

  Future<List<Actor>> getCast(String idPeli) async {
    final url = Uri.https(_url, '3/movie/$idPeli/credits', {
      'api_key': _apiKey,
      'language': _languaje,
    });

    final res = await http.get(url);

    // Crea un Map del res
    final decodedData = json.decode(res.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    // Genera la url
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _languaje,
      'query': query,
    });

    return await _procesarRes(url);
  }
}
