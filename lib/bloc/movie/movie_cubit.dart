import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movie/movie_states.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movies_details_model.dart';
import 'package:movie_app/data/models/video_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/services/api.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(MovieInitState());

  int tapIndex = 0;
  int length = 10;
  MovieModel? top5Movies;
  MovieModel? popularMovies;
  MovieModel? top5Series;
  MovieModel? popularSeries;
  MovieDetails? movieDetails;
  MovieDetails? serieDetails;

  void setTabIndex(int index) {
    tapIndex = index;
    emit(ToggleTabState());
  }

  void setLength(int length_) {
    length = length_;
    emit(SetLengthState());
  }

  Future getMovieDetails({required int id}) async {
    emit(GetMovieDetailsLoadingState());
    Api.get(endPoint: '/movie/$id').then((value) async {
      print(value);

      movieDetails = MovieDetails.fromJson(value.data);
      emit(GetMovieDetailsSuccessState(movieDetails!));
    }).catchError((error, t) {
      print(error);
      print(t);
      emit(GetMovieDetailsErrorState(error.toString()));
    });
  }

  String? videoKey;

  Future getMovieTrailer({required int id, required String movieOrTv}) async {
    videoKey = null;
    emit(GetMovieTrailerLoadingState());
    await Api.get(endPoint: '/$movieOrTv/$id/videos').then((value) {
      print(value);

      final trailer = VideoModel.fromJson(value.data);

      String? trailerKey = trailer.results!
          .firstWhere((element) =>
              element.site == 'YouTube' && element.type == 'Trailer')
          .key;
      print(trailerKey);

      videoKey = trailerKey;

      emit(GetMovieTrailerSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetMovieTrailerErrorState());
    });
  }

  Future getTop5Movies() async {
    emit(GetTop5MoviesLoadingState());
    Api.get(endPoint: '/movie/top_rated').then((value) async {
      print(value);
       top5Movies = MovieModel.fromJson(value.data);
      await Hive.box('data')
          .put('cashedMovies', MovieModel.fromJson(value.data).toJson());
      emit(GetTop5MoviesSuccessState(top5Movies!));
    }).catchError((error) {
      print(error);
      emit(GetTop5MoviesErrorState(error.toString()));
    });
  }

  Future getMovies({int page = 1}) async {
    emit(GetMoviesLoadingState());
    Api.get(endPoint: '/movie/popular', page: page).then((value) {
      print(value);
      popularMovies = MovieModel.fromJson(value.data);
      setLength(10);
      emit(GetMoviesSuccessState(popularMovies!));
    }).catchError((error) {
      print(error);
      emit(GetMoviesErrorState(error.toString()));
    });
  }

  Future getSerieDetails({required int id}) async {
    emit(GetSerieDetailsLoadingState());
    Api.get(endPoint: '/tv/$id').then((value) {
      print(value);
      serieDetails = MovieDetails.fromJson(value.data);
      emit(GetSerieDetailsSuccessState(serieDetails!));
    }).catchError((error) {
      print(error);
      emit(GetSerieDetailsErrorState(error));
    });
  }

  Future getTop5Series() async {
    emit(GetTop5SeriesLoadingState());
    Api.get(endPoint: '/tv/top_rated').then((value) async {
      print(value);
      top5Series = MovieModel.fromJson(value.data);

      await Hive.box('data').put('cashedSeries', value.data);
      emit(GetTop5SeriesSuccessState(top5Series!));
    }).catchError((error, trace) {
      print(error);
      print(trace);
      emit(GetTop5SeriesErrorState(error.toString()));
    });
  }

  Future getSeries({int page = 1}) async {
    emit(GetTop5SeriesLoadingState());
    Api.get(endPoint: '/tv/popular', page: page).then((value) {
      print(value);
      popularSeries = MovieModel.fromJson(value.data);
      setLength(10);
      emit(GetTop5SeriesSuccessState(popularSeries!));
    }).catchError((error, trace) {
      print(error);
      print(trace);
      emit(GetTop5SeriesErrorState(error.toString()));
    });
  }
}
