

import 'package:hive/hive.dart';


import '../../data.vos/vos/movie_vo.dart';
import '../hive_constants.dart';

class MovieDao{

  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao(){
    return _singleton;
  }
  MovieDao._internal();

  void saveMovies(List<MovieVO> movies)async{
    Map<int,MovieVO> movieMap = Map.fromIterable(movies,key:(movie)=>movie.id,value:(movie)=>movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie)async{
    return getMovieBox().put(movie.id,movie);
  }

  List<MovieVO>getAllMovies(){
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int movieId){
    return getMovieBox().get(movieId);
  }

  ///Reactive Programming
  Stream<void> getAllMoviesEventStream(){
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMovieStream(){
    return Stream.value(getAllMovies()
        .where((element) => element?.isNowPlaying ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getComingSoonMovieStream(){
    return Stream.value(getAllMovies()
        .where((element) => element?.isUpcoming ?? false)
        .toList());
  }

  List<MovieVO> getNowPlayingMovies(){
    if(getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)){
      return getAllMovies()
          .where((element)=>element?.isNowPlaying ?? false)
          .toList();
    }else{
      return [];
    }
  }

  List<MovieVO> getUpcomingMovies(){
    if(getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)){
      return getAllMovies()
          .where((element) => element?.isUpcoming ?? false)
          .toList();
    }else{
      return [];
    }
  }

  Box<MovieVO> getMovieBox(){
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}