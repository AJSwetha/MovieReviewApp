import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    this.backgroundPoster,
    this.poster,
    this.title,
    this.rating,
    this.releaseDate,
    this.plot,
  });

  final String backgroundPoster;
  final String poster;
  final String title;
  final dynamic rating;
  final String releaseDate;
  final String plot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: backgroundPoster == null
              ? Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[800],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(12),
                    shadowColor: Color(0xff0EB6DE),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/original$backgroundPoster'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Column(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 10,
                              shadowColor: Color(0xff0EB6DE),
                              borderRadius: BorderRadius.circular(12),
                              child: poster == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/original$poster'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff0EB6DE),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 35,
                                fontFamily: 'Poppins'),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Rating :',
                                  style: TextStyle(
                                      color: Color(0xff80CBA8),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 25,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '$rating',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  'Release Date   :',
                                  style: TextStyle(
                                      color: Color(0xff80CBA8),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 25,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Expanded(
                                child: FittedBox(
                                  child: Text(
                                    '$releaseDate',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],
                )),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Summary :',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Color(0xff0EB6DE),
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 35,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Text(
                                  plot,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey[400],
                                    fontStyle: FontStyle.italic,
                                    fontSize: 25,
                                    letterSpacing: .5,
                                    wordSpacing: 3,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
