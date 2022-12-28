import 'package:flutter/material.dart';
import 'package:movie_app/presentation/screens/movie_details_screen.dart';

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
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MovieDetailsScreen(
                                isMovie: true,
                                id: cubit.top5Movies!.results![index].id!,
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
                                    "https://image.tmdb.org/t/p/w500${cubit.top5Movies!.results![index].posterPath!}",
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
                                        cubit
                                            .top5Movies!.results![index].title!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        cubit.top5Movies!.results![index]
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
                                            cubit.top5Movies!.results![index]
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
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MovieDetailsScreen(
                                isMovie: false,
                                id: cubit.top5Series!.results![index].id!,
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
                                    "https://image.tmdb.org/t/p/w500${cubit.top5Series!.results![index].posterPath!}",
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
                                        cubit.top5Series!.results![index].name!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        cubit.top5Series!.results![index]
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
                                            cubit.top5Series!.results![index]
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
                    separatorBuilder: (ctx, index) => const SizedBox(width: 10),
                  ),
                ),
              ],
            ),
          );
  }
}
