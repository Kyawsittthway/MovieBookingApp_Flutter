import 'package:movie_booking_app/data.vos/vos/actor_vo.dart';

import 'package:movie_booking_app/data.vos/vos/credit_vo.dart';

import 'package:movie_booking_app/data.vos/vos/genre_vo.dart';
import 'package:movie_booking_app/persistence/dao/credit_dao.dart';
import 'package:movie_booking_app/persistence/dao/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/movie_data_agent.dart';
import '../../network/retrofit_data_agent_impl.dart';
import '../vos/movie_vo.dart';
import 'movie_model.dart';

class MovieModelImpl extends MovieModel {

  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();
  @override
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }


  MovieModelImpl._internal();

  ///Daos
  MovieDao mMovieDao = MovieDao();
  CreditDao mCreditDao = CreditDao();

  @override
  void getNowPlayingMovies(int page) {
     mDataAgent.getNowPlayingMovies(page).then((movies)async{
      List<MovieVO>nowPlayingMovies = movies.map((movie){
        movie.isNowPlaying = true;
        movie.isUpcoming = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  void getUpcomingMovies(int page) {
     mDataAgent.getUpcomingMovies(page).then((movies)async{
      List<MovieVO>upcomingMovies = movies.map((movie){
        movie.isNowPlaying = false;
        movie.isUpcoming = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(upcomingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return mDataAgent.getActors(page);
  }

  @override
  void getCreditsByMovie(int movieId) {
      mDataAgent.getCreditsByMovie(movieId).then((credits) async{
      mCreditDao.saveAllCreditsByMovieId(credits, movieId);
      return Future.value(credits);
    });
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return mDataAgent.getGenres();
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
   return mDataAgent.getMovieDetails(movieId).then((movie) async{
     MovieVO movieDetailFromDatabase = await getMovieDetailsFromDatabase(movieId);
     movie.isUpcoming = movieDetailFromDatabase.isUpcoming;
     movie.isNowPlaying = movieDetailFromDatabase.isNowPlaying;
     mMovieDao.saveSingleMovie(movie);
     return Future.value(movie);
   });
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int page) {
    return mDataAgent.getMoviesByGenre(page);
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMovieStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>> getUpcomingMoviesFromDatabase() {
    this.getUpcomingMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getUpcomingMovies())
        .map((event) => mMovieDao.getUpcomingMovies());

  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Stream<List<CreditVO>?> getCreditsByMovieFromDatabase(int movieId) {
    this.getCreditsByMovie(movieId);
    return mCreditDao
        .getAllCreditsEventStream()
        .startWith(mCreditDao.getCreditsListByMovieId(movieId))
        .map((event) => mCreditDao.getCreditsListByMovieId(movieId));
  }


}