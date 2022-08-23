import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/pages/movie_search_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/fonts.dart';
import 'package:movie_booking_app/viewitems/movie_view.dart';

import '../common_widgets_view/interfont_text_widget.dart';
import '../resources/dimens.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tabItems = ["Now Showing", "Coming soon"];

  bool isNowShowing = false;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: HOMEPAGE_APP_BAR_COLOR,
        leading: Icon(CupertinoIcons.paperplane),
        title: InterFontTextWidget(
          "Yangon",
          fontStyle: FontStyle.italic,
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  MovieSearchPage(isNowShowing: false)),
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
              BannerView(),
              SizeBoxH30(),
              TabBarView(
                tabItems: tabItems,
                isNowShowing: isNowShowing,
              ),
              SizeBoxH30(),
              MovieSectionView(
                isNowShowing: isNowShowing,
              ),
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
            selectedIndex = index;
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

  MovieSectionView({required this.isNowShowing});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 20),
        height: MediaQuery.of(context).size.height * 0.38,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.2),
            ),
            padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
            scrollDirection: Axis.vertical,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(child: MovieView(nowShowing: isNowShowing),onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MovieDetailPage()),
                );
              },);
            }),
      ),
    );
  }
}

class TabBarView extends StatefulWidget {
  TabBarView({
    required this.tabItems,
    required this.isNowShowing,
  });

  final List<String> tabItems;
  late bool isNowShowing;

  @override
  State<TabBarView> createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  widget.isNowShowing = !widget.isNowShowing;
                  print("value :: ${widget.isNowShowing}");
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
    );
  }
}

class BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: SMALL_PADDING),
      height: MediaQuery.of(context).size.height / 4,
      child: PageView(
        padEnds: true,
        children: [
          Container(
            child: Image.asset("assets/icons/banner.png"),
          ),
          Container(
            child: Image.asset("assets/icons/banner.png"),
          ),
        ],
      ),
    );
  }
}
