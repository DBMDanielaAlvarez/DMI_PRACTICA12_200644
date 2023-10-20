import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp_200644/common/Constants.dart';
import 'package:movieapp_200644/model/Media.dart';

class HttpHandler {
  static final _httpHandler = new HttpHandler();
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-US";

  static HttpHandler get() {
    return _httpHandler;
  }

  Future<dynamic> getJson(Uri uri) async {
    http.Response response = await http.get(uri);
    return json.decode(response.body);
  }

  /*Future<List<Media>> fetchMovies() {
    var uri = new Uri.https(_baseUrl, "3/movie/popular",
        {'api_key': API_KEY, 'page': "1", 'language': _lenguage});

    return getJson(uri).then(((data) =>
        data['results'].map<Media>((item) => new Media(item, MediaType.movie)).toList()));
  }*/

  /*Future<List<Media>> fetchShow() {
    var uri = new Uri.https(_baseUrl, "3/tv/popular",
        {'api_key': API_KEY, 'page': "1", 'language': _lenguage});

    return getJson(uri).then(((data) =>
        data['results'].map<Media>((item) => new Media(item, MediaType.show)).toList()));
  }*/

  /*Future<List<Media>> fetchMovies({String category = "populares"}) async {
    var uri = new Uri.https(_baseUrl, "3/movie/$category",
        {'api_key': API_KEY, 'page': "1", 'language': _lenguage});

    return getJson(uri).then(((data) =>
        data['results'].map<Media>((item) => new Media(item, MediaType.movie)).toList()));
  }*/

  Future<List<Media>> fetchMovies({String category = "populares"}) async {
  var uri = new Uri.https(_baseUrl,"3/movie/$category", 
  {'api_key': API_KEY, 'page': "1", 'language': _language});

  return getJson(uri).then((data) {
    if (category == "upcoming") {
      var sortedResults = data['results']
          .where((item) => item['release_date'] != null)
          .toList()
            ..sort((a, b) {
              DateTime dateA = DateTime.parse(a['release_date']);
              DateTime dateB = DateTime.parse(b['release_date']);
              return dateB.compareTo(dateA);
            });

      return sortedResults
          .map<Media>((item) => new Media(item, MediaType.movie))
          .toList();
    } else {
      return data['results']
          .map<Media>((item) => new Media(item, MediaType.movie))
          .toList();
    }
  });
}

  Future<List<Media>> fetchShow({String category = "populares"}) async {
    var uri = new Uri.https(_baseUrl, "3/tv/$category",
        {'api_key': API_KEY, 'page': "1", 'language': _language});

    return getJson(uri).then(((data) =>
        data['results'].map<Media>((item) => new Media(item, MediaType.show)).toList()));
  }
}
