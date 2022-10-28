import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/production_company_vo.dart';
import 'package:movie_booking_app/data.vos/vos/production_country_vo.dart';
import 'package:movie_booking_app/data.vos/vos/spoken_language_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';

import '../../persistence/hive_constants.dart';
import 'collection_vo.dart';
import 'genre_vo.dart';

part 'movie_vo.g.dart';
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO,adapterName: "MovieVOAdapter")
@JsonSerializable()

class MovieVO{

  @JsonKey(name:"adult")
  @HiveField(0)
  bool adult;

  @JsonKey(name:"backdrop_path")
  @HiveField(1)
  String backDropPath;

  @JsonKey(name:"genre_ids")
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name:"belongs_to_collection")
  @HiveField(3)
  CollectionVO? belongToCollection;

  @JsonKey(name:"budget")
  @HiveField(4)
  double? budget;

  @JsonKey(name:"genres")
  @HiveField(5)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(6)
  String homepage;

  @JsonKey(name:"id")
  @HiveField(7)
  int id;

  @JsonKey(name:"imdb_id")
  @HiveField(8)
  String? imdbId;

  @JsonKey(name:"original_language")
  @HiveField(9)
  String originalLanguage;

  @JsonKey(name:"original_title")
  @HiveField(10)
  String originalTitle;

  @JsonKey(name:"overview")
  @HiveField(11)
  String overview;

  @JsonKey(name:"popularity")
  @HiveField(12)
  double? popularity;

  @JsonKey(name:"poster_path")
  @HiveField(13)
  String posterPath;

  @JsonKey(name:"production_companies")
  @HiveField(14)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name:"production_countries")
  @HiveField(15)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name:"revenue")
  @HiveField(16)
  int? revenue;

  @JsonKey(name:"runtime")
  @HiveField(17)
  int? runtTime;

  @JsonKey(name:"spoken_languages")
  @HiveField(18)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name:"status")
  @HiveField(19)
  String? status;

  @JsonKey(name:"tagline")
  @HiveField(20)
  String? tagLine;

  @JsonKey(name:"release_date")
  @HiveField(21)
  String releaseDate;

  @JsonKey(name:"title")
  @HiveField(22)
  String title;

  @JsonKey(name:"video")
  @HiveField(23)
  bool video;

  @JsonKey(name:"vote_average")
  @HiveField(24)
  double voteAverage;

  @JsonKey(name:"vote_count")
  @HiveField(25)
  int voteCount;

  @HiveField(28)
  bool isNowPlaying;

  @HiveField(27)
  bool isUpcoming;



  factory MovieVO.fromJson(Map<String,dynamic>json) => _$MovieVOFromJson(json);

  Map<String,dynamic>toJson()=>_$MovieVOToJson(this);

  String? getReleaseDay(){
    return releaseDate.substring(8,releaseDate.length);
  }
  String? getReleaseYear(){
    return releaseDate.substring(0,4);
  }
  String? getReleaseDate(){
    return "${getReleaseDay()} ${getReleaseMonth()} ${getReleaseYear()} ";
  }

  String? getFullBackDropPath(){
    return IMAGE_BASE_URL+backDropPath;
  }
  String? getFullPosterPath(){
    return IMAGE_BASE_URL+posterPath;
  }
  String? getDuration(){
    if(runtTime != null || runtTime == 0){
      int totalHour = (runtTime! / 60).toInt();
      int totalMinutes = (runtTime! % 60).toInt();
      print("Run time from get duration :: $totalHour");
      return "${totalHour}hr ${totalMinutes}mins";
    }else{
      return "TBA";
    }


  }
  String? getReleaseMonth(){
    Map<String,String> monthConverter = {
      "01":"Jan",
      "02":"Feb",
      "03":"Mar",
      "04":"Apr",
      "05":"May",
      "06":"Jun",
      "07":"Jul",
      "08":"Aug",
      "09":"Sep",
      "10":"Oct",
      "11":"Nov",
      "12":"Dec",
    };
    String month = releaseDate.substring(5,7);
    return  monthConverter[month];
  }

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }

  MovieVO(
      this.adult,
      this.backDropPath,
      this.genreIds,
      this.belongToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.revenue,
      this.runtTime,
      this.spokenLanguages,
      this.status,
      this.tagLine,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.isNowPlaying,
      this.isUpcoming);
}

