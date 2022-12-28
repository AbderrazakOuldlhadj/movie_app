import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/search/search_cubit.dart';
import 'package:movie_app/bloc/search/search_states.dart';

import '../components/components.dart';
import 'movie_details_screen.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) {
          SearchCubit cubit = BlocProvider.of(ctx);
          return Scaffold(
            appBar: AppBar(title: const Text('Search')),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                      hintText: "Search",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onFieldSubmitted: (value) async {
                      print('submit');
                      await cubit.getResults(query: value);
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: state is SearchLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : cubit.results == null
                            ? const Center(child: Text('No results'))
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: cubit.results!.length,
                                itemBuilder: (cx, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => MovieDetailsScreen(
                                            isMovie: true,
                                            id: cubit.results![index].id!,
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
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                "https://image.tmdb.org/t/p/original${cubit.results![index].posterPath.toString()}",
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
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.pinkAccent,
                                                    //Colors.redAccent.withOpacity(.5),
                                                    Colors.pinkAccent
                                                        .withOpacity(.1),
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
                                                        .results![index].title!,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    cubit.results![index]
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
                                                        cubit.results![index]
                                                            .voteAverage!
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                },
                                separatorBuilder: (cx, index) =>
                                    const SizedBox(height: 10),
                              ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
