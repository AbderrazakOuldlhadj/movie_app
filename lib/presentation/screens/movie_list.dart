import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie/movie_states.dart';

import '../../bloc/movie/movie_cubit.dart';
import '../components/components.dart';
import 'movie_details_screen.dart';

class MovieList extends StatelessWidget {
  MovieCubit cubit;

  MovieStates state;
  bool isMovie;

  MovieList(this.cubit, this.state, [this.isMovie = true]);

  @override
  Widget build(BuildContext context) {
    return cubit.popularMovies == null ||
            cubit.popularSeries == null ||
            state is GetMoviesLoadingState ||
            state is GetSeriesLoadingState
        ? const Center(
            child: CircularProgressIndicator(color: primaryColor),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.length,
                  itemBuilder: (ctx, index) {
                    return isMovie
                        ? InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MovieDetailsScreen(
                                    isMovie: isMovie,
                                    id: cubit
                                        .popularMovies!.results![index].id!,
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
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${cubit.popularMovies!.results![index].posterPath!}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.popularMovies!.results![index]
                                                .title!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            cubit.popularMovies!.results![index]
                                                .originalTitle!,
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
                                                cubit
                                                    .popularMovies!
                                                    .results![index]
                                                    .voteAverage!
                                                    .toString(),
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
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MovieDetailsScreen(
                                    isMovie: isMovie,
                                    id: cubit
                                        .popularSeries!.results![index].id!,
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
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${cubit.popularSeries!.results![index].posterPath!}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.popularSeries!.results![index]
                                                .name!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            cubit.popularSeries!.results![index]
                                                .originalName!,
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
                                                cubit
                                                    .popularSeries!
                                                    .results![index]
                                                    .voteAverage!
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                  separatorBuilder: (ctx, index) => const SizedBox(height: 10),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    int length = isMovie
                        ? cubit.popularMovies!.results!.length
                        : cubit.popularSeries!.results!.length;
                    cubit.setLength(length);
                  },
                  child: cubit.length == 10
                      ? const Text(
                          'view all',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (cubit.length > 10)
                              InkWell(
                                onTap: () async {
                                  int? page = isMovie
                                      ? cubit.popularMovies!.page
                                      : cubit.popularSeries!.page;
                                  if (page == 1) {
                                    cubit.setLength(10);
                                  } else {
                                    isMovie
                                        ? await cubit.getMovies(page: page! - 1)
                                        : await cubit.getSeries(
                                            page: page! - 1);
                                  }
                                },
                                child: const Text(
                                  'previous',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            Text(
                              'page: ${isMovie ? cubit.popularMovies!.page : cubit.popularSeries!.page}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            InkWell(
                              onTap: () async {
                                isMovie
                                    ? await cubit.getMovies(
                                        page: cubit.popularMovies!.page! + 1)
                                    : await cubit.getSeries(
                                        page: cubit.popularSeries!.page! + 1);
                              },
                              child: const Text(
                                '    next',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
  }
}
