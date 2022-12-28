import 'package:bloc/bloc.dart';
import 'package:movie_app/bloc/search/search_states.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/services/api.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  List<Results>? results;
  List<Results>? serieResults;

  int tapIndex = 0;

  void setTabIndex(int id) {
    tapIndex = id;
    emit(TabState());
  }

  Future getResults({required String query}) async {
    emit(SearchLoadingState());
    Api.getSearch(endPoint: '/search/movie', query: query).then((value) {
      final movie = MovieModel.fromJson(value.data);
      results = movie.results;
      emit(SearchSuccessState());
    }).catchError((error, trace) {
      print(error);
      print(trace);
      emit(SearchErrorState());
    });
  }

  Future getSerieResults({required String query}) async {
    emit(SearchLoadingState());
    Api.getSearch(endPoint: '/search/tv', query: query).then((value) {
      final movie = MovieModel.fromJson(value.data);
      serieResults = movie.results;
      emit(SearchSuccessState());
    }).catchError((error, trace) {
      print(error);
      print(trace);
      emit(SearchErrorState());
    });
  }
}
