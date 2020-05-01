import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tmdb/models/movie.dart';

class Details extends StatefulWidget {
  final Movie movie;

  const Details({Key key, this.movie}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 56, 72, 1),
      body: Container(
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _TopImage(imagePosterPath: widget.movie.poster),
              _DetailsInfo(movie: widget.movie)
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsInfo extends StatelessWidget {
  final Movie movie;

  const _DetailsInfo({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              movie.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('WATCH NOW'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: RatingBarIndicator(
                  rating: movie.average,
                  itemCount: 5,
                  itemSize: 18.0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Text(movie.overview),
          ),
          _Infos(movie: movie)
        ],
      ),
    );
  }
}

class _Infos extends StatelessWidget {
  final Movie movie;

  const _Infos({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  'Studio',
                  style: Theme.of(context).textTheme.body2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Container(
                      width: 250,
                      child: Text(
                        movie.studios,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Genre',
                  style: Theme.of(context).textTheme.body2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Container(
                      width: 250,
                      child: Text(
                        movie.genres,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Release',
                  style: Theme.of(context).textTheme.body2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Container(
                      child: Text(
                    movie.release,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopImage extends StatelessWidget {
  final String imagePosterPath;

  const _TopImage({Key key, this.imagePosterPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      width: screenSize.width,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(this.imagePosterPath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
