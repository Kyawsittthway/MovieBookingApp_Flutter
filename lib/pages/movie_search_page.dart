import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/resources/colors.dart';

import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/movie_view.dart';

class MovieSearchPage extends StatefulWidget {

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {

  @override
  List<String> genre = ["Action", "Comedy", "Drama"];

  List<String> format = ["2D", "3D", "3D IMAX"];

  List<String> month = ["January", "February", "March"];
  String dropDownValue = "Genre";

  Widget build(BuildContext context) {
  //  print("MovieSearchPage isNowShowing :: ${widget.isNowShowing}");
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: LARGE_ICON_SIZE,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            width: LARGE_TEXTFIELD_SIZE,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: SEARCH_MOVIE_HINT_TEXT,
                hintStyle: TextStyle(color: MOVIE_SEARCH_HINT_COLOR),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_off_outlined),
            color: GREEN_BUTTON_COLOR,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: SMALL_PADDING),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropDownView(genre: genre, hint: "Genre"),
                  DropDownView(genre: format, hint: "Format"),
                  Visibility(visible: CurrentAppState.isNowShowing,child: DropDownView(genre: month, hint: "Month")),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: SMALL_PADDING_2X, top: SMALL_PADDING_2X),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.2),
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: MovieView(
                        nowShowing: CurrentAppState.isNowShowing,inputMovie:null ,
                      ),
                      onTap: (){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>  MovieDetailPage()),
                        // );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownView extends StatelessWidget {
  const DropDownView({
    required this.hint,
    required this.genre,
  });

  final List<String> genre;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27.0,
      width: 81.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
      ),
      child: DropdownButton(
        isExpanded: true,
        style: TextStyle(color: Colors.blue),
        icon: Icon(Icons.keyboard_arrow_down_outlined),
        hint: Text(
          hint,
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        onChanged: (String? newValue) {
          // setState(() {
          //   dropDownValue = newValue!;
          //   print(dropDownValue);
          // });
        },
        items: genre.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
