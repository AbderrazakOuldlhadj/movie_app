import 'package:flutter/material.dart';

import '../../bloc/movie/movie_cubit.dart';
import '../../bloc/movie/movie_states.dart';
import '../components/components.dart';

class TopRated extends StatelessWidget {
  MovieCubit cubit;
  MovieStates state;

  TopRated(this.cubit, this.state);

  @override
  Widget build(BuildContext context) {
    return cubit.top5Movies == null ||
            cubit.top5Series == null ||
            state is GetTop5MoviesLoadingState ||
            state is GetTop5SeriesLoadingState
        ? const Center(
            child: CircularProgressIndicator(color: primaryColor),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Films',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 310,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return MovieWidget(
                        context: context,
                        movie: cubit.top5Movies!.results![index],
                        isMovie: true,
                      );
                    },
                    separatorBuilder: (ctx, index) => const SizedBox(width: 10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Series',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 310,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return MovieWidget(
                        context: context,
                        movie: cubit.top5Series!.results![index],
                        isMovie: false,
                      );
                    },
                    separatorBuilder: (ctx, index) => const SizedBox(width: 10),
                  ),
                ),
              ],
            ),
          );
  }
}
