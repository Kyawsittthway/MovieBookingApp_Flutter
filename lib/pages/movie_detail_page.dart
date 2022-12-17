import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/button_with_circle_cuts.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/config/config_values.dart';
import 'package:movie_booking_app/config/environment_config.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/data.vos/models/movie_model_impl.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/pages/chose_time_cinema.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/fonts.dart';

import '../common_widgets_view/custom_chip_view.dart';
import '../common_widgets_view/size_box_r12.dart';
import '../data.vos/models/movie_model.dart';
import '../data.vos/vos/actor_vo.dart';
import '../data.vos/vos/credit_vo.dart';
import '../data.vos/vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  MovieDetailPage({required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  List<String> genreList = [
    "Action",
    "Drama",
    "Adventure",
    "Classic",
  ];
  MovieModel movieModel = MovieModelImpl();
  MovieVO? movieDetails;
  List<CreditVO> actorList = [];
  List<CreditVO> creditList = [];

  void initState() {
    super.initState();

    ///Movie Detail
    movieModel.getMovieDetails(widget.movieId).then((details) {
      setState(() {
        movieDetails = details;
        genreList = movieDetails?.genres?.map((genre) => genre.name).toList() ??
            genreList;
      });
      print("Movie Detials :: ${details}");
    }).catchError((error) {
      print("The movie detail error ${error}");
    });

    ///Movie Detail Database
    movieModel.getMovieDetailsFromDatabase(widget.movieId).then((details) {
      setState(() {
        movieDetails = details;
        genreList = movieDetails?.genres?.map((genre) => genre.name).toList() ??
            genreList;
      });
      print("Movie Details From Database :: $details");
    }).catchError((error) {
      print("Error fetching movie detail from database");
    });

    /// Credits
    // movieModel.getCreditsByMovie(widget.movieId).then((credit){
    //   setState(() {
    //     creditList = credit;
    //     actorList = credit.where((credit)=>credit.isActor()).toList();
    //   });
    // }).catchError((error){print("Get actor error ${error}");});

    ///Credits from Database
    movieModel.getCreditsByMovieFromDatabase(widget.movieId).listen((credit) {
      setState(() {
        if (credit?.isNotEmpty == true) {
          creditList = credit!;
          actorList = credit.where((credit) => credit.isActor()).toList();
          print("Credits from db :: ${creditList}");
          print("Credits from db(actor) :: ${actorList}");
        }
      });
    }).onError((error) {
      print("Error fetching credits from database :: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      body: (movieDetails != null)
          ? Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          TrailerSection(
                            inputPosterpath:
                                movieDetails?.getFullBackDropPath() ?? "",
                          ),
                          PosterView(
                            posterPath: movieDetails?.getFullPosterPath() ?? "",
                          ),
                          Positioned(
                            height: MOVIE_DETAIL_POSTER_HEIGHT,
                            width: MediaQuery.of(context).size.width -
                                MOVIE_DETAIL_POSTER_WIDTH,
                            top: MOVIE_DETAIL_POSTER_TOP_POSITION,
                            left: MOVIE_DETAIL_POSTER_LEFT_POSITION,
                            child: Container(
                              height: MOVIE_DETAIL_POSTER_HEIGHT,
                              width: MOVIE_DETAIL_POSTER_WIDTH,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleAndRatingView(
                                      rating: movieDetails?.voteAverage,
                                      movieTitle: movieDetails?.title,
                                    ),
                                    SizeBoxH12(),
                                    AvailableTypesView(),
                                    SizeBoxH12(),
                                    CustomChipView(
                                      genreList: genreList,
                                      chipHeight:
                                          MOVIE_DETAIL_GENRE_CHIP_VIEW_HEIGHT,
                                      chipWidth:
                                          MOVIE_DETAIL_GENRE_CHIP_VIEW_WIDTH,
                                      isCenter: true,
                                    ),
                                    SizeBoxH30(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: KILO_HEIGHT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MovieDetailBoardView(
                          duration: movieDetails?.getDuration(),
                          releaseDate: movieDetails?.getReleaseDate(),
                        ),
                      ],
                    ),
                    SizeBoxH30(),
                    // Container(
                    //   height: 154.0,
                    //   width: 370.0,
                    //   decoration: BoxDecoration(
                    //       gradient: LinearGradient(colors: [
                    //         MOVIE_DETAIL_REMINDER_GRADIENT_COLOR3,
                    //         MOVIE_DETAIL_REMINDER_GRADIENT_COLOR2,
                    //         MOVIE_DETAIL_REMINDER_GRADIENT_COLOR1,
                    //       ]),
                    //       borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)),
                    //   child: ReminderView(),
                    // ),
                    ReminderViewSection(),
                    SizeBoxH30(),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                      child: InterFontTextWidget(
                        MOVIE_DETIAL_STORLINE_HEADING_TEXT,
                        fontWeight: FontWeight.w600,
                        fontSize: SMALL_FONT_SIZE_14,
                      ),
                    ),
                    SizeBoxH12(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                      child: InterFontTextWidget(
                        movieDetails?.overview ?? "",
                        fontWeight: FontWeight.w500,
                        fontSize: SMALL_FONT_SIZE_14,
                        align: TextAlign.left,
                      ),
                    ),
                    SizeBoxH30(),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                      child: InterFontTextWidget(
                        MOVIE_DETAIL_CASTS_HEADING_TEXT,
                        fontWeight: FontWeight.w600,
                        fontSize: SMALL_FONT_SIZE_14,
                      ),
                    ),
                    SizeBoxH12(),
                    /// will return respective actor list view according to build flavour
                    returnRespectiveActorView(actorList),

                    SizedBox(
                      height: MOVIE_DETAIL_SIZED_BOX_H45,
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: Visibility(
          visible: !CurrentAppState.isNowShowing,
          child: CircleCutButtonWidget(
            buttonName: MOVIE_DETAIL_CIRCLE_CUT_BUTTON_NAMME,
            onTapFunction: () {
              CurrentAppState.receipt.movieName = movieDetails?.title ?? "";
              CurrentAppState.movieId = movieDetails?.id ?? 0;
              CurrentAppState.moviePoster =
                  movieDetails?.getFullPosterPath() ?? "";
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseTimeCinema()),
              );
            },
            inputColor: GREEN_BUTTON_COLOR,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

returnRespectiveActorView(List<CreditVO> actorList) {
  if ((ACTOR_LIST_STYLES[EnvironmentConfig.CONFIG_ACTOR_LIST_STYLE] ==
      ActorListStyle.WrapActorList)) {
    return Wrap(
      spacing: MEDIUM_PADDING,
      runSpacing: MEDIUM_PADDING,
      children: actorList
          .map((actor) => ActorViewItem(
                actorName: actor.name,
                actorImage: actor.getFullProfile() ?? "",
              ))
          .toList(),
    );
  } else {
    return Container(
      height: KILO_HEIGHT_2X,
      margin: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: actorList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ActorViewItem(
            actorImage: actorList[index].getFullProfile() ?? "",
            actorName: actorList[index].name,
          );
        },
      ),
    );
  }
}

class ActorViewItem extends StatelessWidget {
  const ActorViewItem({required this.actorImage, required this.actorName});

  final String actorImage;
  final String actorName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: SMALL_PADDING),
      child: Column(
        children: [
          Container(
            height: KILO_HEIGHT,
            width: KILO_WIDTH,
            child: CircleAvatar(
              backgroundImage: NetworkImage(actorImage),
            ),
          ),
          SizeBoxH12(),
          InterFontTextWidget(
            actorName,
            fontWeight: FontWeight.w500,
            fontSize: NORMAL_FONT_SIZE,
          )
        ],
      ),
    );
  }
}

class ReminderViewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: CurrentAppState.isNowShowing,
      child: Container(
        height: MOVIE_DETAIL_REMINDER_SECTION_HEIGHT,
        width: MOVIE_DETAIL_REMINDER_SECTION_WIDTH,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              MOVIE_DETAIL_REMINDER_GRADIENT_COLOR3,
              MOVIE_DETAIL_REMINDER_GRADIENT_COLOR2,
              MOVIE_DETAIL_REMINDER_GRADIENT_COLOR1,
            ]),
            borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)),
        child: ReminderView(),
      ),
    );
  }
}

class ReminderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: KILO_WIDTH_2X,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InterFontTextWidget("Releasing in 5 days"),
              SizeBoxH12(),
              InterFontTextWidget(
                MOVIE_DETAIL_REMINDER_VIEW_GET_NOTIFY_TEXT,
                fontSize: SMALL_FONT_SIZE_14,
                color: MOVIE_DETAIL_REMINDER_TEXT_COLOR,
              ),
              SizeBoxH12(),
              Container(
                height: MOVIE_DETAIL_REMINDER_SECTION_REMINDER_BUTTON_HEIGHT,
                width: MOVIE_DETAIL_REMINDER_SECTION_REMINDER_BUTTON_WIDTH,
                decoration: BoxDecoration(
                    color: GREEN_BUTTON_COLOR,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications),
                    Text(MOVIE_DETAIL_SET_NOTIFICATION_BUTTON_TEXT)
                  ],
                ),
              ),
              SizedBox(
                height: MEDIUM_HEIGHT,
              ),
            ],
          ),
        ),
        Container(
          width: MOVIE_DETAIL_REMINDER_SECTION_REMINDER_IMAGE_WIDTH,
          height: MOVIE_DETAIL_REMINDER_SECTION_REMINDER_IMAGE_HEIGHT,
          child: Image.asset("assets/icons/reminder.png"),
        )
      ],
    );
  }
}

class MovieDetailBoardView extends StatelessWidget {
  final String? duration;
  final String? releaseDate;

  MovieDetailBoardView({required this.duration, required this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovieDetailBoard(
          inputHeight: MOVIE_DETAIL_MOVIE_DETAIL_BOARD_CENSOR_HEIGHT,
          inputWidth: MOVIE_DETAIL_MOVIE_DETAIL_BOARD_CENSOR_WIDTH,
          heading: MOVIE_DETAIL_CENSOR_RATING_HEADER_TEXT,
          description: "U/A",
        ),
        SizeBoxR12(),
        MovieDetailBoard(
          inputHeight: MOVIE_DETAIL_MOVIE_DETAIL_BOARD_RELEASE_HEIGHT,
          inputWidth: MOVIE_DETAIL_MOVIE_DETAIL_BOARD_RELEASE_WIDTH,
          heading: MOVIE_DETAIL_RELEASE_DATE_HEADER_TEXT,
          description: releaseDate ?? "",
        ),
        SizeBoxR12(),
        MovieDetailBoard(
          inputHeight: MOVIE_DETAIL_MOVIE_DETAIL_BOARD_DURATION_HEIGHT,
          inputWidth: MOVIE_DETAIL_MOVIE_DETAIL_BOARD_DURATION_WIDTH,
          heading: MOVIE_DETAIL_DURATION_HEADER_TEXT,
          description: duration ?? "",
        ),
      ],
    );
  }
}

class MovieDetailBoard extends StatelessWidget {
  final double inputHeight;
  final double inputWidth;
  final String heading;
  final String description;

  MovieDetailBoard(
      {required this.inputHeight,
      required this.inputWidth,
      required this.heading,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: inputHeight,
      width: inputWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            MOVIE_DETAIL_GRADIENT_COLOR1,
            MOVIE_DETAIL_GRADIENT_COLOR2,
          ],
        ),
        boxShadow: [
          BoxShadow(color: MOVIE_DETAIL_SHADOW_COLOR, blurRadius: 2.0)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InterFontTextWidget(
            heading,
            fontSize: NORMAL_FONT_SIZE,
          ),
          SizeBoxH12(),
          InterFontTextWidget(
            description,
            fontSize: SMALL_FONT_SIZE_14,
          )
        ],
      ),
    );
  }
}

// class CustomChipView extends StatelessWidget {
//    CustomChipView({
//     required this.genreList,
//   });
//
//   final List<String> genreList;
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: SMALL_PADDING,
//       runSpacing: SMALL_PADDING,
//       children: genreList
//           .map((genre) => GenreChipView(
//                 genre: genre,
//               ))
//           .toList(),
//     );
//   }
// }

class AvailableTypesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InterFontTextWidget("2D,3D,3D IMAX,3D DBOX",
          fontSize: SMALL_FONT_SIZE_14),
    );
  }
}

class TitleAndRatingView extends StatelessWidget {
  final String? movieTitle;
  final double? rating;

  TitleAndRatingView({required this.movieTitle, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          child: InterFontTextWidget(movieTitle ?? ""),
          width: 150,
        ),
        Padding(
          padding:
              EdgeInsets.only(right: SMALL_PADDING, left: SMALL_PADDING_2X),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/imdb_icon.png",
                height: IMDB_ICON_HEIGHT,
                width: IMDB_ICON_WIDTH,
              ),
              InterFontTextWidget(
                "${rating?.toStringAsFixed(1)}",
                fontStyle: FontStyle.italic,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PosterView extends StatelessWidget {
  final String posterPath;

  PosterView({required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: MOVIE_DETAIL_POSTER_HEIGHT,
      width: MOVIE_DETAIL_POSTER_WIDTH,
      top: MOVIE_DETAIL_POSTERVIEW_TOP_POSITION,
      left: MOVIE_DETAIL_POSTERVIEW_LEFT_POSITION,
      child: Container(
        height: MOVIE_DETAIL_POSTER_HEIGHT,
        width: MOVIE_DETAIL_POSTER_WIDTH,
        child: Image.network(posterPath),
      ),
    );
  }
}

// class GenreChipView extends StatelessWidget {
//   final String genre;
//
//   GenreChipView({required this.genre});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MOVIE_DETAIL_GENRE_CHIP_VIEW_WIDTH,
//       height: MOVIE_DETAIL_GENRE_CHIP_VIEW_HEIGHT,
//       child: Container(
//
//         decoration: BoxDecoration(
//           color: GREEN_BUTTON_COLOR,
//           borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
//           boxShadow: [
//             BoxShadow(color: GREEN_BUTTON_COLOR, blurRadius: 1.0)
//           ],
//         ),
//         child: Center(
//             child: InterFontTextWidget(
//           genre,
//           fontSize: NORMAL_FONT_SIZE,
//           color: Colors.black,
//           fontWeight: FontWeight.w500,
//         )),
//       ),
//     );
//   }
// }

class TrailerSection extends StatelessWidget {
  TrailerSection({required this.inputPosterpath});

  final String inputPosterpath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              inputPosterpath,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_circle_fill_outlined,
                color: MOVIE_VIEW_TEXT_COLOR_LOW_OPACITY,
                size: PLAY_BUTTON_ICON_SIZE,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: MEDIUM_PADDING),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.chevron_left,
                  color: MOVIE_VIEW_TEXT_COLOR,
                  size: PLAY_BUTTON_ICON_SIZE,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  right: SMALL_PADDING,
                  top: MOVIE_DETAIL_TOP_RIGHT_ICON_TOP_POSITION),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: MOVIE_VIEW_TEXT_COLOR,
                  size: NORMAL_ICON_SIZE,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
