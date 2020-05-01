import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tmdb/api/services/movies_service.dart';
import 'package:flutter_tmdb/components/loading.dart';
import 'package:flutter_tmdb/models/movie.dart';
import 'package:flutter_tmdb/pages/details.dart';

class MovieList extends StatefulWidget {
  final Future<List<Movie>> movies;

  const MovieList({Key key, this.movies}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 290.0,
              child: FutureBuilder<List<Movie>>(
                initialData: List(),
                future: widget.movies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        break;
                      case ConnectionState.waiting:
                        return Loading(visible: true);
                        break;
                      case ConnectionState.active:
                        break;
                      case ConnectionState.done:
                        return _movies(snapshot.data);
                        break;
                    }
                    return null;
                  } else {
                    return Loading(visible: false);
                  }
                },
              ),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _movies(List<Movie> movies) {
    return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (_, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
                child: Container(
                  height: 190.0,
                  width: 140.0,
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(movies[index].imagePath),
                    ),
                  ),
                ),
                onTap: () =>
                    _navigateToDetails(context, selectedMovie: movies[index])),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                width: 140,
                child: new Tooltip(
                  message: movies[index].title,
                  child: new Text(
                    movies[index].title,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 5.0),
              child: RatingBarIndicator(
                rating: movies[index].average,
                itemCount: 5,
                itemSize: 18.0,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _navigateToDetails(BuildContext context, {Movie selectedMovie}) {
    MoviesService.getAdditionalInfo(selectedMovie.id, 'studios')
        .then((studios) => selectedMovie.studios = studios)
        .then((result) => MoviesService.getAdditionalInfo(
              selectedMovie.id,
              'genres',
            ).then((genres) => selectedMovie.genres = genres))
        .then(
          (value) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Details(movie: selectedMovie),
            ),
          ),
        );
  }
}
