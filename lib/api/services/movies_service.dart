import 'dart:convert';
import 'package:flutter_tmdb/api/web_client.dart';
import 'package:flutter_tmdb/models/movie.dart';
import 'package:http/http.dart';

class MoviesService {
  static Future<List<Movie>> getPlayings() async {
    final Response response = await client
        .get('$baseUrl/movie/$endpointPlaying/?api_key=$apiKey');
    return _toMovies(response);
  }

  static Future<List<Movie>> getPopular() async {
    final Response response = await client
        .get('$baseUrl/movie/$endpointPopular/?api_key=$apiKey');
    return _toMovies(response);
  }

  static Future<List<Movie>> getTopRated() async {
    final Response response = await client
        .get('$baseUrl/movie/$endpointTopRated/?api_key=$apiKey');
    return _toMovies(response);
  }

  static Future<List<Movie>> getUpcoming() async {
    final Response response = await client
        .get('$baseUrl/movie/$endpointUpcoming/?api_key=$apiKey');
    return _toMovies(response);
  }

  static Future<List<Movie>> query(name) async {
    final Response response = await client.get(
        '$baseUrl/$endpointSearch/movie?api_key=$apiKey&query=$name');
    return _toMovies(response);
  }

  static Future<String> getAdditionalInfo(id, additionalInfo) async {
    final response =
        await client.get('$baseUrl/movie/$id?api_key=$apiKey');

    switch (additionalInfo) {
      case 'genres':
        return _arrayToString(response, 'genres');
      case 'studios':
        return _arrayToString(response, 'production_companies');
      default:
        return 'Not informed';
    }
  }

  static _toMovies(Response response) {
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    final List<dynamic> jsonList = decodedJson['results'];
    return jsonList.map((json) => Movie.fromJson(json)).toList();
  }

  static String _arrayToString(Response response, String field) {
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    final List<dynamic> jsonList = decodedJson[field];
    String stringResult = '';

    if (jsonList != null && jsonList.length > 0) {
      for (Map<String, dynamic> json in jsonList) {
        stringResult = stringResult + json['name'] + ', ';
      }
      return stringResult.substring(0, stringResult.length -2);
    } else {
      return 'Not informed';
    }
  }
}
