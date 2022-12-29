import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie/movie_states.dart';

import '../../../bloc/movie/movie_cubit.dart';
import '../../components/components.dart';



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
                    final movie = isMovie
                        ? cubit.popularMovies!.results![index]
                        : cubit.popularSeries!.results![index];

                    return MovieWidget(
                      context: context,
                      movie: movie,
                      isMovie: isMovie,
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
