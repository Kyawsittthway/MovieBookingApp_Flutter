import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/pages/chose_time_cinema.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/fonts.dart';

import '../common_widgets_view/size_box_r12.dart';
import '../resources/dimens.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  List<String> genreList = [
    "Action",
    "Drama",
    "Adventure",
    "Classic",
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SafeArea(
                child: Container(
                  height: 0.0,
                ),
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    TrailerSection(),
                    PosterView(),
                    Positioned(
                      height: MOVIE_DETAIL_POSTER_HEIGHT,
                      width: MediaQuery.of(context).size.width -
                          MOVIE_DETAIL_POSTER_WIDTH,
                      top: 210,
                      left: 150,
                      child: Container(
                        height: MOVIE_DETAIL_POSTER_HEIGHT,
                        width: MOVIE_DETAIL_POSTER_WIDTH,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleAndRatingView(),
                              SizeBoxH12(),
                              AvailableTypesView(),
                              SizeBoxH12(),
                              CustomChipView(genreList: genreList),
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
                height: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MovieDetailBoardView(),
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
              Container(
                height: 167.0,
                width: 370.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      MOVIE_DETAIL_REMINDER_GRADIENT_COLOR3,
                      MOVIE_DETAIL_REMINDER_GRADIENT_COLOR2,
                      MOVIE_DETAIL_REMINDER_GRADIENT_COLOR1,
                    ]),
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)),
                child: ReminderView(),
              ),
              SizeBoxH30(),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                child: InterFontTextWidget(
                  "Story Line",
                  fontWeight: FontWeight.w600,
                  fontSize: SMALL_FONT_SIZE_14,
                ),
              ),
              SizeBoxH12(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                child: InterFontTextWidget(
                  "In the 1970s, young Gru tries to join a group of supervillains called the Vicious 6 after they oust their leader -- the legendary fighter Wild Knuckles. When the interview turns disastrous, Gru and his Minions go on the run with the Vicious 6 hot on their tails. Luckily, he finds an unlikely source for guidance -- Wild Knuckles himself -- and soon discovers that even bad guys need a little help from their friends.",
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
                  "Casts",
                  fontWeight: FontWeight.w600,
                  fontSize: SMALL_FONT_SIZE_14,
                ),
              ),
              SizeBoxH12(),
              Container(
                height: 200,
                margin: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: EdgeInsets.only(right: SMALL_PADDING),
                          child: Column(children: [
                            Container(
                              height:100,
                              width: 100,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRuZUvi4ngHzU-8MgO5gPn0tFv5y0zxBXip0ec-le3W1aQ-QnjI"),
                              ),
                            ),
                            SizeBoxH12(),
                            InterFontTextWidget("Emma Mackey",fontWeight: FontWeight.w500,fontSize: NORMAL_FONT_SIZE,)
                            
                          ]));
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ChooseTimeCinema()),
          );
        },
        child: Container(
          width: 238,
          height: 50,
          decoration: BoxDecoration(
            color: GREEN_BUTTON_COLOR,
            borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)
          ),
      
          child: Center(child: InterFontTextWidget("Book Now",color: Colors.black,)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InterFontTextWidget("Releasing in 5 days"),
              SizeBoxH12(),
              InterFontTextWidget(
                "Get notify as soon as movie booking opens up in your city!",
                fontSize: SMALL_FONT_SIZE_14,
                color: MOVIE_DETAIL_REMINDER_TEXT_COLOR,
              ),
              SizeBoxH12(),
              Container(
                height: 35.0,
                width: 150.0,
                decoration: BoxDecoration(
                    color: GREEN_BUTTON_COLOR,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications),
                    Text("Set Notificaton")
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
        Container(
          width: 86.0,
          height: 127.0,
          child: Image.asset("assets/icons/reminder.png"),
        )
      ],
    );
  }
}

class MovieDetailBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovieDetailBoard(
          inputHeight: 58,
          inputWidth: 100,
          heading: "Censor Rating",
          description: "U/A",
        ),
        SizeBoxR12(),
        MovieDetailBoard(
          inputHeight: 60,
          inputWidth: 150,
          heading: "Release Date",
          description: "November 12th,2022",
        ),
        SizeBoxR12(),
        MovieDetailBoard(
          inputHeight: 58,
          inputWidth: 100,
          heading: "Duration",
          description: "2hr 20mins",
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

class CustomChipView extends StatelessWidget {
  const CustomChipView({
    required this.genreList,
  });

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: genreList
          .map((genre) => GenreChipView(
                genre: genre,
              ))
          .toList(),
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        InterFontTextWidget("Emily"),
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
                "8.0",
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
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: MOVIE_DETAIL_POSTER_HEIGHT,
      width: MOVIE_DETAIL_POSTER_WIDTH,
      top: 160,
      left: 10,
      child: Container(
        height: MOVIE_DETAIL_POSTER_HEIGHT,
        width: MOVIE_DETAIL_POSTER_WIDTH,
        child: Image.network(
            "https://upload.wikimedia.org/wikipedia/en/d/db/Emily_%282022_film%29_poster.png"),
      ),
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genre;

  GenreChipView({required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 63,
      height: 26,
      child: Row(
        children: [
          Container(
            height: 25,
            width: 63,
            decoration: BoxDecoration(
              color: GREEN_BUTTON_COLOR,
              borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
              boxShadow: [
                BoxShadow(color: GREEN_BUTTON_COLOR, blurRadius: 1.0)
              ],
            ),
            child: Center(
                child: InterFontTextWidget(
              genre,
              fontSize: NORMAL_FONT_SIZE,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )),
          ),
        ],
      ),
    );
  }
}

class TrailerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://m.media-amazon.com/images/M/MV5BMzFhZmYzZjYtYTZlOS00ZmNkLWE4YzYtNDQzNjI3MjlmZWY5XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg",
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
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chevron_left,
                color: MOVIE_VIEW_TEXT_COLOR,
                size: PLAY_BUTTON_ICON_SIZE,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  right: SMALL_PADDING, top: SMALL_PADDING - 4.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: MOVIE_VIEW_TEXT_COLOR,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
