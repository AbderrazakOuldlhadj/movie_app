import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/search/search_cubit.dart';
import 'package:movie_app/bloc/search/search_states.dart';

import '../components/components.dart';

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
                        Icons.search,
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
                      cubit.tapIndex == 0
                          ? await cubit.getResults(query: value)
                          : await cubit.getSerieResults(query: value);
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TabWidget(text: 'Movies', id: 0, cubit: cubit),
                      TabWidget(text: 'Series', id: 1, cubit: cubit),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: state is SearchLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : (cubit.tapIndex == 0 &&
                                    (cubit.results == null ||
                                        cubit.results!.isEmpty)) ||
                                (cubit.tapIndex == 1 &&
                                    (cubit.serieResults == null ||
                                        cubit.serieResults!.isEmpty))
                            ? const Center(child: Text('No results'))
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: cubit.tapIndex == 0
                                    ? cubit.results!.length
                                    : cubit.serieResults!.length,
                                itemBuilder: (cx, index) {
                                  final movie = cubit.tapIndex == 0
                                      ? cubit.results![index]
                                      : cubit.serieResults![index];
                                  return MovieWidget(
                                    context: context,
                                    movie: movie,
                                    isMovie: cubit.tapIndex == 0,
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
