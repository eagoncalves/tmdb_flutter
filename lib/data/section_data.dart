import 'package:flutter_tmdb/models/section.dart';
import 'package:flutter_tmdb/api/services/movies_service.dart';

List<Section> getSections(bool isSearching, { String search }) {
  if (isSearching) {
    return [
      new Section(
        title: 'SEARCHED',
        movies: MoviesService.query(search),
      ),
    ];
  } else {
    return [
      new Section(
        title: 'RECOMMENDED FOR YOU',
        movies: MoviesService.getPlayings(),
      ),
      new Section(
        title: 'POPULAR',
        movies: MoviesService.getPopular(),
      ),
      new Section(
        title: 'TOP RATED',
        movies: MoviesService.getTopRated(),
      ),
      new Section(
        title: 'UPCOMING',
        movies: MoviesService.getUpcoming(),
      ),
    ];
  }

}
