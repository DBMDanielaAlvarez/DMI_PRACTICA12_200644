import 'dart:async';
import 'package:movieapp_200644/common/HttpHandler.dart';
import 'package:movieapp_200644/model/Media.dart';

abstract class MediaProvider {
  /*Future<List<Media>> fetchMedia();*/
  Future<List<Media>> fetchMedia(String category);
}

class MovieProvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchMovies(category: category);
  }
}

class ShowProvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchShow(category: category);
  }
}
