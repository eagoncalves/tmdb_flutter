import 'package:flutter_tmdb/api/services/movies_service.dart';
import 'package:flutter_tmdb/api/web_client.dart';

class Movie {
  final int id;
  final String title;
  final double average;
  final String imagePath;
  final String poster;
  final String overview;
  final String release;
  String _genres;
  String _studios;

  Movie(this.id, this.title, this.average, this.imagePath, this.poster,
      this.overview, this.release);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        average = _getAverage(json['vote_average']),
        imagePath = _getPathImage(json['poster_path'], false),
        poster = _getPathImage(json['backdrop_path'], true),
        overview = json['overview'],
        release = json['release_date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'vote_average': average,
        'poster_path': imagePath,
        'backdrop': poster,
        'overview': overview,
        'release': release,
        'studios': _studios,
        'genres': _genres,
      };

  set genres(String value) => _genres = value;

  set studios(String value) => _studios = value;

  String get studios => _studios;

  String get genres => _genres;

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, average: $average, imagePath: $imagePath, poster: $poster, overview: $overview, release: $release}';
  }
}

String _getPathImage(String posterPath, bool poster) {
  if (poster) {
    return '$urlBaseImg/w780$posterPath';
  } else {
    return '$urlBaseImg/w154$posterPath';
  }
}

double _getAverage(dynamic average) {
  try {
    if (average.runtimeType == int) {
      return double.tryParse(average.toString()) / 2;
    } else {
      return average / 2;
    }
  } catch (err) {
    return 0.0;
  }
}

String getAddtionInfo(int id, String field) {
  MoviesService.getAdditionalInfo(id, field).then((string) {
    return string;
  }).catchError((error) => 'Not Informed');
}
