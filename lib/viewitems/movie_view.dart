import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';

import '../common_widgets_view/dm_san_text_widget.dart';
import '../data.vos/vos/movie_vo.dart';
import '../resources/colors.dart';

class MovieView extends StatelessWidget {
  late bool nowShowing;
  MovieVO? inputMovie;
  MovieView({required this.nowShowing,required this.inputMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0, right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)
      ),
      child: Stack(
        children: [
          PosterView(inputPosterPath: inputMovie?.posterPath,),
          GradientView(),
          DescriptionView(inputTitle: inputMovie?.title,inputImagePath: inputMovie?.posterPath,),
          ReleaseTag(nowShowing: nowShowing,inputReleaseDay: inputMovie?.getReleaseDay(),inputReleaseMonth: inputMovie?.getReleaseMonth(),),
        ],
      ),
    );
  }
}

class ReleaseTag extends StatelessWidget {
   ReleaseTag({
    required this.nowShowing,
     required this.inputReleaseDay,
     required this.inputReleaseMonth

  });

  final bool nowShowing;
  final String? inputReleaseMonth;
  final String? inputReleaseDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: SMALL_PADDING, top: SMALL_PADDING),
      child: Align(
        alignment: Alignment.topRight,
        child: Visibility(
          visible: nowShowing,
          child: Container(
            height: MOVIE_VIEW_RELEASE_TAG_HEIGHT,
            width: MOVIE_VIEW_RELEASE_TAG_WIDTH,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL),
                color: GREEN_BUTTON_COLOR),
            child: Column(
              children: [
                DmSanTextWidget(
                  inputReleaseDay ?? "?",
                  fontSize: SMALL_FONT_SIZE_10,
                  color: MOVIE_VIEW_RELEASE_TAG_TEXT_COLOR,
                ),
                DmSanTextWidget(
                  inputReleaseMonth ?? "?",
                  fontSize: SMALL_FONT_SIZE_10,
                  color: MOVIE_VIEW_RELEASE_TAG_TEXT_COLOR,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptionView extends StatelessWidget {
  String? inputTitle;
  String? inputImagePath;
  DescriptionView({
    required this.inputTitle,
    required this.inputImagePath
});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieTextFirstRow(inputTitle: inputTitle,),
            MovieTextSecondRow(),
          ],
        ),
      ),
    );
  }
}

class MovieTextSecondRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SMALL_PADDING_2X),
      child: Row(
        children: [
          InterFontTextWidget(
            "U/A",
            color: MOVIE_VIEW_TEXT_COLOR,
            fontSize: NORMAL_FONT_SIZE,
            fontWeight: FontWeight.w600,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: Container(
              width: DOT_WIDTH,
              height: DOT_HEIGHT,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BORDER_RADIUS_CIRCLE),
                color: MOVIE_VIEW_DOT_COLOR,
              ),
            ),
          ),
          Container(
            width: 100,
            child: InterFontTextWidget(
              "2D,3D,3D IMAX,DBOX,3D",
              fontWeight: FontWeight.w400,
              fontSize: SMALL_FONT_SIZE_10,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieTextFirstRow extends StatelessWidget {
   MovieTextFirstRow({
    required this.inputTitle,
  });
  String? inputTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          child: Text(
            inputTitle ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
            color: MOVIE_VIEW_TEXT_COLOR,
            fontSize: NORMAL_FONT_SIZE,

            fontWeight: FontWeight.w500,
            )
          ),
        ),
        Row(
          children: [
            Image.asset(
              "assets/icons/imdb_icon.png",
              fit: BoxFit.cover,
              height: IMDB_ICON_HEIGHT,
              width: IMDB_ICON_WIDTH,
            ),
            InterFontTextWidget(
              "8.0",
              color: MOVIE_VIEW_TEXT_COLOR,
              fontSize: NORMAL_FONT_SIZE,
              fontStyle: FontStyle.italic,
            )
          ],
        )
      ],
    );
  }
}

class GradientView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                MOVIE_VIEW_GRADIENT_COLOR1,
                MOVIE_VIEW_GRADIENT_COLOR2,
              ]),
        ),
      ),
    );
  }
}

class PosterView extends StatelessWidget {
  String? inputPosterPath;
  PosterView({
    required this.inputPosterPath
});
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Positioned.fill(
        child: Container(
          height: MOVIE_POSTER_HEIGHT,
          width: MOVIE_POSTER_WIDTH,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
            child: Image.network(
                 "$IMAGE_BASE_URL$inputPosterPath",
                fit: BoxFit.fitHeight),
          ),
        ),
      ),
    );
  }
}
