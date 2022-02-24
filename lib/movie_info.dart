import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'movie_card.dart';

class MovieInfo extends StatelessWidget {
  final String title;
  final String plot;
  final String poster;
  final String backgroundPoster;
  final dynamic rating;
  final String releaseDate;
  MovieInfo(
      {this.title,
      this.backgroundPoster,
      this.plot,
      this.poster,
      this.rating,
      this.releaseDate});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff032541),
      body: SafeArea(
        child: MovieCard(
            backgroundPoster: backgroundPoster,
            poster: poster,
            title: title,
            rating: rating,
            releaseDate: releaseDate,
            plot: plot),
      ),
    );
  }
}
