import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/data/models/movie_model.dart';

import '../screens/login_screen.dart';
import '../screens/movie_details_screen.dart';

const primaryColor = Colors.pinkAccent;
const titleTextStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
const subTitleTextStyle = TextStyle(fontSize: 20);

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    gravity: ToastGravity.CENTER,
  );
}

// ignore: non_constant_identifier_names
Widget TabWidget({required String text, required int id, required cubit}) {
  return InkWell(
    onTap: () => cubit.setTabIndex(id),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: id != cubit.tapIndex
          ? null
          : BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: primaryColor.withOpacity(.5),
                    offset: const Offset(1, 1),
                    blurRadius: 5),
                BoxShadow(
                  color: primaryColor.withOpacity(.5),
                  offset: const Offset(-1, -1),
                  blurRadius: 5,
                ),
              ],
            ),
      child: Text(
        text,
        style: TextStyle(
          color: id != cubit.tapIndex ? Colors.black : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget MovieWidget(
    {required BuildContext context,
    required Results movie,
    bool isMovie = true}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(
            isMovie: isMovie,
            id: movie.id!,
          ),
        ),
      );
    },
    child: SizedBox(
      height: 300,
      width: 230,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: movie.posterPath != null
                  ? Image.network(
                      "https://image.tmdb.org/t/p/original${movie.posterPath.toString()}",
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(height: 300, width: 230),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.pinkAccent,
                    //Colors.redAccent.withOpacity(.5),
                    Colors.pinkAccent.withOpacity(.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMovie ? movie.title! : movie.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.originalTitle ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        movie.voteAverage!.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

signOut(context) async {
  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  // await Hive.box('data').delete(HiveKeys.token);
}
