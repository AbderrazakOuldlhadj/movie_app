import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movie/movie_states.dart';

import '../../../bloc/movie/movie_cubit.dart';
import '../../components/components.dart';

class MovieList extends StatefulWidget {
  MovieCubit cubit;

  MovieStates state;
  bool isMovie;

  MovieList(this.cubit, this.state, [this.isMovie = true]);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {


  @override
  Widget build(BuildContext context) {
    return widget.cubit.popularMovies == null ||
            widget.cubit.popularSeries == null ||
            widget.state is GetMoviesLoadingState ||
            widget.state is GetSeriesLoadingState
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
                  itemCount: widget.cubit.length,
                  itemBuilder: (ctx, index) {
                    final movie = widget.isMovie
                        ? widget.cubit.popularMovies!.results![index]
                        : widget.cubit.popularSeries!.results![index];

                    return MovieWidget(
                      context: context,
                      movie: movie,
                      isMovie: widget.isMovie,
                    );
                  },
                  separatorBuilder: (ctx, index) => const SizedBox(height: 10),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    int length = widget.isMovie
                        ? widget.cubit.popularMovies!.results!.length
                        : widget.cubit.popularSeries!.results!.length;
                    widget.cubit.setLength(length);
                  },
                  child: widget.cubit.length == 10
                      ? const Text(
                          'view all',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (widget.cubit.length > 10)
                              InkWell(
                                onTap: () async {
                                  int? page = widget.isMovie
                                      ? widget.cubit.popularMovies!.page
                                      : widget.cubit.popularSeries!.page;
                                  if (page == 1) {
                                    widget.cubit.setLength(10);
                                  } else {
                                    widget.isMovie
                                        ? await widget.cubit
                                            .getMovies(page: page! - 1)
                                        : await widget.cubit
                                            .getSeries(page: page! - 1);
                                  }
                                },
                                child: const Text(
                                  'previous',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            Text(
                              '${widget.isMovie ? widget.cubit.popularMovies!.page : widget.cubit.popularSeries!.page}/${widget.isMovie ? widget.cubit.popularMovies!.page : widget.cubit.popularSeries!.totalPages}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            InkWell(
                              onTap: () async {
                                widget.isMovie
                                    ? await widget.cubit.getMovies(
                                        page:
                                            widget.cubit.popularMovies!.page! +
                                                1)
                                    : await widget.cubit.getSeries(
                                        page:
                                            widget.cubit.popularSeries!.page! +
                                                1);
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
