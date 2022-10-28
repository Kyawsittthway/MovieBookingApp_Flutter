import '../vos/actor_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/genre_vo.dart';
import '../vos/movie_vo.dart';

abstract class MovieModel {

  ///Network
  void getNowPlayingMovies(int page);
  void getUpcomingMovies(int page);
  Future<List<GenreVO>> getGenres();
  Future<List<MovieVO>> getMoviesByGenre(int page);
  Future<List<ActorVO>> getActors(int page);
  Future<MovieVO> getMovieDetails(int movieId);
  void getCreditsByMovie(int movieId);

  ///Database
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>> getUpcomingMoviesFromDatabase();
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId);
  Stream<List<CreditVO>?>getCreditsByMovieFromDatabase(int movieId);
}