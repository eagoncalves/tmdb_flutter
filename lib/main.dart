import 'package:flutter/material.dart';
import 'package:flutter_tmdb/pages/dashboard.dart';

void main() => runApp(new TheMovie());

class TheMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueGrey[600],
          textTheme: ButtonTextTheme.primary,
          padding: new EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.transparent)),
        ),
        textTheme: TextTheme(
          body1: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
              letterSpacing: 1,
              height: 1.5),
          body2: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
              height: 1.5),
        ),
      ),
      home: Dashboard(),
    );
  }
}
