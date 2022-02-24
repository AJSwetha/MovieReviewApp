import 'package:flutter/material.dart';
import 'package:movie_review_app/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Review App',
      home: SearchScreen(),
    );
  }
}
