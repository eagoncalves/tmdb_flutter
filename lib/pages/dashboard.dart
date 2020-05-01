import 'package:flutter/material.dart';
import 'package:flutter_tmdb/components/movie_list.dart';
import 'package:flutter_tmdb/data/section_data.dart';
import 'package:flutter_tmdb/models/section.dart';

List<Section> sections = getSections(false);

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print(MediaQuery.of(context).devicePixelRatio);
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TopDashboard(screenSize: screenSize),
            Expanded(
              child: _MainContainer(),
            )
          ],
        ),
      ),
    );
  }
}

class _TopDashboard extends StatelessWidget {
  final Size screenSize;

  const _TopDashboard({Key key, this.screenSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AspectRatio(
        aspectRatio: 3/2,
        child: Container(
          width: screenSize.width,
          padding: new EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(color: Colors.blue[300]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hello, what do you',
                      style: TextStyle(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'want to watch ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: new EdgeInsets.only(left: 50, right: 50),
                height: 40,
                child: _SearchTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchTextField extends StatefulWidget {
  @override
  __SearchTextFieldState createState() => __SearchTextFieldState();
}

class __SearchTextFieldState extends State<_SearchTextField> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(1.0, 0.0),
      children: <Widget>[
        TextFormField(
          controller: _textController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white70,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                this.setState(() {
                  sections = getSections(false);
                  Future.delayed(Duration(milliseconds: 50))
                      .then((_) => _textController.clear());
                });
              },
            ),
            hintText: 'Search',
            filled: true,
            fillColor: Colors.blue[200],
            hintStyle: new TextStyle(
              color: Colors.grey[300],
              fontSize: 18,
            ),
            contentPadding: new EdgeInsets.only(top: 10),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: _onChange,
        ),
      ],
    );
  }

  void _onChange(String text) {
    setState(() {
      if (text != null && text != '') {
        sections = getSections(true, search: text);
      } else {
        sections = getSections(false);
      }
    });
  }
}

class _MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(44, 56, 72, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (_, ind) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 20,
                  padding: new EdgeInsets.only(left: 20, right: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sections[ind].title,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Sell All',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                MovieList(movies: sections[ind].movies),
              ],
            ),
          );
        },
      ),
    );
  }
}
