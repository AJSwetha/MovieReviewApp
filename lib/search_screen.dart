import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:movie_review_app/movie_info.dart';

const baseUrl = 'https://api.themoviedb.org/3/search/movie';
const apiKey = 'api_key=99fecc3fa060673392ea39ba5a8cba27';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var data;
  var page;
  String movieName = 'enthiran';
  Future<dynamic> getMovieInfo() async {
    List<MovieInfo> movieInfo = [];
    String url = '$baseUrl?query=$movieName&$apiKey&page=$page';
    var apiResponse = await get(url);
    data = jsonDecode(apiResponse.body);
    if (data['total_pages'] == 1) {
      for (var info in data['results']) {
        MovieInfo movie = MovieInfo(
          title: info['title'],
          poster: info['poster_path'],
          backgroundPoster: info['backdrop_path'],
          releaseDate: info['release_date'],
          rating: info['vote_average'],
          plot: info['overview'],
        );
        movieInfo.add(movie);
      }
    } else if (data['total_pages'] > 1) {
      for (page = 1; page <= data['total_pages']; page++) {
        for (var info in data['results']) {
          MovieInfo movie = MovieInfo(
            title: info['title'],
            poster: info['poster_path'],
            backgroundPoster: info['backdrop_path'],
            releaseDate: info['release_date'],
            rating: info['vote_average'],
            plot: info['overview'],
          );
          movieInfo.add(movie);
        }
        url = '$baseUrl?query=$movieName&$apiKey&page=$page';
        apiResponse = await get(url);
        data = jsonDecode(apiResponse.body);
      }
    }

    return movieInfo;
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xff0EB6DE).withOpacity(.95),
      appBar: AppBar(
        title: Center(
          child: Text(
            "TMDB",
            style: TextStyle(
              fontSize: 40,
              color: Color(0xff80CBA8),
              letterSpacing: 4,
              shadows: <Shadow>[
                Shadow(
                    color: Color(0xff0EB6DE),
                    blurRadius: 50,
                    offset: Offset(0, 0)),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xff032541),
        toolbarHeight: 200,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              enabled: true,
              autofocus: false,
              controller: controller,
              textAlign: TextAlign.center,
              cursorColor: Color(0xff032541),
              decoration: InputDecoration(
                hintText: 'Enter a Movie Name',
                hintStyle: TextStyle(
                  color: Color(0xff032541).withOpacity(.5),
                  fontFamily: 'Poppins',
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff80CBA8),
                    width: 5,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff80CBA8),
                    width: 5,
                  ),
                ),
              ),
              onChanged: (val) {
                movieName = val;
              },
              onSubmitted: (newValue) {
                movieName = newValue;
                setState(() {});
              },
            ),
          ),
          MaterialButton(
            elevation: 4,
            child: Text(
              'Search',
              style: TextStyle(color: Colors.grey[300], fontFamily: 'Poppins'),
            ),
            onPressed: () {
              setState(() {});
            },
            color: Color(0xff80CBA8),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: getMovieInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xff032541),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            color: Color(0xff0EB6DE),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: snapshot.data[index].poster == null
                                  ? Container(
                                      width: 50,
                                      color: Colors.black26,
                                      child: Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/original${snapshot.data[index].poster}'))),
                                    ),
                              title: Text(
                                snapshot.data[index].title,
                                style: TextStyle(
                                  color: Colors.grey[350],
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            MovieInfo(
                                              releaseDate: snapshot
                                                  .data[index].releaseDate,
                                              rating:
                                                  snapshot.data[index].rating,
                                              title: snapshot.data[index].title,
                                              plot: snapshot.data[index].plot,
                                              poster:
                                                  snapshot.data[index].poster,
                                              backgroundPoster: snapshot
                                                  .data[index].backgroundPoster,
                                            ),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, widget) {
                                          var curve = Curves.ease;
                                          var begin = Offset(0.0, 1.0);
                                          var end = Offset.zero;

                                          var tween = Tween(
                                                  begin: 0.0, end: 1.0)
                                              .chain(CurveTween(curve: curve));
                                          var tween2 = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          return ScaleTransition(
                                            scale: animation.drive(tween),
                                            child: SlideTransition(
                                              position: animation.drive(tween2),
                                              child: widget,
                                            ),
                                          );
                                        }));
                              },
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
