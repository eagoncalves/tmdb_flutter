import 'movie.dart';

class Section {
  final String title;
  final Future<List<Movie>> movies;

  Section({this.title, this.movies});
}
