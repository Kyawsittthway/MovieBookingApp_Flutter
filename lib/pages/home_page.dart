 import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/data.vos/models/movie_model.dart';
import 'package:movie_booking_app/data.vos/models/movie_model_impl.dart';
import 'package:movie_booking_app/data.vos/models/padc_api_model.dart';
import 'package:movie_booking_app/data.vos/models/padc_api_model_impl.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/pages/movie_search_page.dart';
import 'package:movie_booking_app/pages/profile_page.dart';
import 'package:movie_booking_app/pages/search_cinema_page.dart';
import 'package:movie_booking_app/pages/your_ticket_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/fonts.dart';
import 'package:movie_booking_app/viewitems/movie_view.dart';

import '../common_widgets_view/interfont_text_widget.dart';
import '../data.vos/vos/banner_image_vo.dart';
import '../data.vos/vos/movie_vo.dart';
import '../resources/dimens.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    List<String> tabItems = ["Now Showing", "Coming soon"];
    int selectedIndex = 0;
    List<BannerImageVO>? bannerImages = [];
    List<MovieVO> getNowPlaying = [];
    List<MovieVO>getUpcoming = [];
    PadcApiModel padcApiModel = PadcApiModelImpl();
    MovieModel movieModel = MovieModelImpl();

    @override
    void initState(){
      super.initState();
      CurrentAppState.currentFoodItems.clear();

      ///Banner Images
      padcApiModel.getBannersResponse().then((banners){
        setState((){
          bannerImages = banners;
        });

      }).catchError((error){
        print("Error from Get Banner Response:: ${error}");
      });

      ///Banner Images Database
      padcApiModel.getBannersResponseFromDatabase().then((banners){
        setState(() {
          bannerImages = banners;
        });
      }).catchError((error){
        print("Error fetching Banner Images from Database :: $error");
      });


      ///Now Playing Movie
      // movieModel.getNowPlayingMovies(1).then((nowPlayings){
      //   setState((){
      //     getNowPlaying = nowPlayings;
      //     print("get now playing :: ${getNowPlaying}");
      //   });
      //
      // }).catchError((error){
      //   print("Error from Get nowplaying Response:: ${error}");
      // });

      ///Now Playing Movie Database
      movieModel.getNowPlayingMoviesFromDatabase().listen((nowPlayings){
        setState(() {
          getNowPlaying = nowPlayings;
        });
      }).onError((error){
        print("Error from Get nowplaying movies DB :: $error");
      });


      ///Upcoming Movie
      // movieModel.getUpcomingMovies(2).listen((upcomings){
      //   setState((){
      //     getUpcoming = upcomings;
      //     print("get upcomings :: ${getUpcoming}");
      //   });
      //
      // }).catchError((error){
      //   print("Error from Get nowplaying Response:: ${error}");
      // });

      ///Upcoming Movies From Database
      movieModel.getUpcomingMoviesFromDatabase().listen((upcomings){
        setState(() {
          getUpcoming = upcomings;
        });
      }).onError((error){
        print("Error fetching upcoming movies from database :: $error");
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        appBar: AppBar(
          backgroundColor: HOMEPAGE_APP_BAR_COLOR,
          leading: Icon(CupertinoIcons.paperplane),
          title: InterFontTextWidget(
            "${CurrentAppState.currentCityname}",
            fontStyle: FontStyle.italic,
          ),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MovieSearchPage()),
              );
            }, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: () {}, icon: Icon(Icons.qr_code)),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                (bannerImages != null) ? BannerView(inputBannerImages: bannerImages ?? []) : CircularProgressIndicator(),
                SizeBoxH30(),
                TabBarView(
                  tabItems: tabItems,
                  isNowShowing: CurrentAppState.isNowShowing,
                  inputNowShowing: getNowPlaying,
                  inputUpcoming: getUpcoming,

                ),
                // SizeBoxH30(),
                // MovieSectionView(
                //   isNowShowing: isNowShowing,
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: HOMEPAGE_APP_BAR_COLOR,
          onTap: (int index) {
            setState(() {
            switch(index){
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  HomePage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SearchCinemaPage()),
                );
                break;
              case 2:

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  YourTicketPage()),
                );
                break;
              default:
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ProfilePage()),
              );

            }

            });
            print("BOT index :: $index");
          },
          selectedFontSize: SMALL_FONT_SIZE_10,
          selectedIconTheme: IconThemeData(color: GREEN_BUTTON_COLOR),
          selectedItemColor: GREEN_BUTTON_COLOR,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: SELECTED_TAB_TEXT_COLOR,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_fill_outlined),
              label: 'Movie',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'Cinema',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.ticket),
              label: 'Ticket',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      );
    }
}

class MovieSectionView extends StatelessWidget {
  late bool isNowShowing;
  List<MovieVO> inputNowShowing=[];
  List<MovieVO>inputUpcoming = [];
  List<MovieVO> currentChoice = [];

  MovieSectionView({required this.isNowShowing,required this.inputNowShowing,required this.inputUpcoming});

  @override
  Widget build(BuildContext context) {
    isNowShowing == true ? (currentChoice = inputUpcoming) : (currentChoice = inputNowShowing);
    print("isNowShowingValue from Movie Section View :: ${currentChoice}");
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: (MediaQuery.of(context).size.height * 0.35)* (currentChoice.length/2),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: currentChoice.length%2 ==0 ? MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.3): MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.35),
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
            scrollDirection: Axis.vertical,
            itemCount: currentChoice.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(child: MovieView(nowShowing: isNowShowing,inputMovie: currentChoice[index]),onTap: (){

                navigateToMovieDetail(context,currentChoice[index].id);
              },);
            }),
      ),
    );
  }

  void navigateToMovieDetail(BuildContext context,int movieId) {
         Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  MovieDetailPage(movieId: movieId,)),
    );
  }
}

class TabBarView extends StatefulWidget {
  TabBarView({
    required this.tabItems,
    required this.isNowShowing,
    required this.inputNowShowing,
    required this.inputUpcoming
  });

  final List<String> tabItems;
  late bool isNowShowing;
  List<MovieVO> inputNowShowing =[];
  List<MovieVO>inputUpcoming = [];

  @override
  State<TabBarView> createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
        height: TAB_BAR_HEIGHT,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  TAB_BAR_GRADIENT_COLOR1,
                  TAB_BAR_GRADIENT_COLOR2,
                ]),
            borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL)),
        child: DefaultTabController(
          length: widget.tabItems.length,
          child: Container(

            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.all(SMALL_PADDING),
            child: TabBar(
                onTap: (int index) {
                  setState(() {
                    CurrentAppState.isNowShowing = !CurrentAppState.isNowShowing;
                    print("value :: ${CurrentAppState.isNowShowing}");
                  });
                },
                indicator: BoxDecoration(
                    color: GREEN_BUTTON_COLOR,
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL)),
                isScrollable: true,
                labelColor: SELECTED_TAB_TEXT_COLOR,
                indicatorColor: GREEN_BUTTON_COLOR,
                tabs: widget.tabItems
                    .map(
                      (items) => Container(
                        width: TAB_ITEM_WIDTH,
                        child: Tab(
                          child: Text(items),
                        ),
                      ),
                    )
                    .toList()),
          ),
        ),
      ),
        SizeBoxH30(),
        MovieSectionView(
          isNowShowing: CurrentAppState.isNowShowing,
          inputNowShowing:widget.inputNowShowing,
          inputUpcoming: widget.inputUpcoming,
        )
    ]
    );
  }
}

class BannerView extends StatefulWidget {
  final List<BannerImageVO> inputBannerImages;
  BannerView({
    required this.inputBannerImages
});
  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  double _position = 0.0;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: SMALL_PADDING),

      child: Column(
        children: [Container(
          height: MediaQuery.of(context).size.height / 4.5,
          child: PageView(
              padEnds: true,
              onPageChanged: (value){
                setState(() {
                  _position = value.toDouble();
                });
              },
              children:[
                Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.0,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: false,
                        onPageChanged: (index,reason){
                          setState(() {
                            _position = index.toDouble();
                          });
                        }),
                      items: _createPageChilds(),
                    )),
              ],
            ),

         
        ),
          DotsIndicator(
              dotsCount: widget.inputBannerImages.isEmpty? 1:widget.inputBannerImages.length,
              position: _position,
              decorator: DotsDecorator(
                activeColor: GREEN_BUTTON_COLOR,
              ),
          ),
      ]
      ),
    );
  }
 List<Widget>_createPageChilds(){
    List<Widget>widgets =
      widget.inputBannerImages.map((e) => Container(child: Image.network(e.imageURL ?? ""),)).toList();
    return widgets;

 }
}
