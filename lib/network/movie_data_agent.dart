import 'package:movie_booking_app/network/responses/get_genres_response.dart';
import 'package:movie_booking_app/network/responses/movie_list_response.dart';

import '../data.vos/vos/actor_vo.dart';
import '../data.vos/vos/credit_vo.dart';
import '../data.vos/vos/genre_vo.dart';
import '../data.vos/vos/movie_vo.dart';

abstract class MovieDataAgent{
  Future<List<MovieVO>> getNowPlayingMovies(int page);
  Future<List<MovieVO>> getUpcomingMovies(int page);
  Future<List<GenreVO>> getGenres();
  Future<List<MovieVO>> getMoviesByGenre(int page);
  Future<List<ActorVO>> getActors(int page);
  Future<MovieVO> getMovieDetails(int movieId);
  Future<List<CreditVO>> getCreditsByMovie(int movieId);





}