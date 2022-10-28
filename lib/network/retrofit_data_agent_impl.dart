import 'package:dio/dio.dart';
import 'package:movie_booking_app/data.vos/vos/credit_vo.dart';
import 'package:movie_booking_app/network/the_movie_api.dart';

import '../data.vos/vos/actor_vo.dart';
import '../data.vos/vos/genre_vo.dart';
import '../data.vos/vos/movie_vo.dart';
import 'api_constants.dart';
import 'movie_data_agent.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mApi;

  static final RetrofitDataAgentImpl _singleton = RetrofitDataAgentImpl
      ._internal();

  factory RetrofitDataAgentImpl(){
    return _singleton;
  }


  RetrofitDataAgentImpl._internal(){
    const HEADER_REQUESTED_WITH = "X-Requested-With";
    const String XML_HTTP_REQUEST = "XMLHttpRequest";
    final dio = Dio();



    mApi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>> getNowPlayingMovies(int page) {
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results).first;
  }

  @override
  Future<List<MovieVO>> getUpcomingMovies(int page) {
    return mApi
        .getUpcomingMovies(API_KEY,LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results).first;
  }
  @override
  Future<List<GenreVO>> getGenres() {
    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId){
    return mApi
        .getMoviesByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return mApi
        .getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }
  @override
  Future<MovieVO> getMovieDetails(int movieId){
    return mApi
        .getMovieDetails(movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString());
  }

  @override
  Future<List<CreditVO>> getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovieResponse(movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString())
        .asStream()
        .map((response) => response.cast)
        .first;
  }

}