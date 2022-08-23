import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/models/food_items.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';

class FoodAndBeveragePage extends StatefulWidget {
  const FoodAndBeveragePage({Key? key}) : super(key: key);

  @override
  _FoodAndBeveragePageState createState() => _FoodAndBeveragePageState();
}

class _FoodAndBeveragePageState extends State<FoodAndBeveragePage> {
  List<String> foodCategory = ["All", "Popcorn", "Snack", "Combo", "Beverage"];
  List<FoodItem> currentFoodItems = [
    FoodItem(name: "Large Corn", quantity:1 , totalPrice: 1000.0),
    FoodItem(name: "Large Cola", quantity:1 , totalPrice: 1000.0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: MEDIUM_ICON_SIZE,
          ),
          onPressed: () {},
        ),
        title: InterFontTextWidget(
          "Grab a bite!",
          fontSize: APPBAR_TITLE_FONT_SIZE,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          Padding(
              padding: EdgeInsets.only(right: SMALL_PADDING),
              child: TextButton(
                  onPressed: () {},
                  child: InterFontTextWidget("SKIP",
                      fontSize: APPBAR_TEXT_BUTTON_FONT_SIZE)))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: SMALL_PADDING, horizontal: SMALL_PADDING),
            child: DefaultTabController(
                length: foodCategory.length,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: GREEN_BUTTON_COLOR,
                  tabs: foodCategory
                      .map((category) => Tab(
                            child: Text(category),
                          ))
                      .toList(),
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.68,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.35),
                ),
                itemCount: 8,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 100,
                    height: 95,
                    margin: EdgeInsets.all(SMALL_PADDING),
                    padding: EdgeInsets.symmetric(horizontal:SMALL_PADDING),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(BORDER_RADIUS_NORMAL),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              FNB_GRADIENT_COLOR1,
                              FNB_GRADIENT_COLOR2
                            ])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            child: Image.asset(
                              "assets/icons/cola.png",
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),
                        SizeBoxH12(),
                        InterFontTextWidget(
                          "Cocacola Large",
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: NORMAL_FONT_SIZE,
                        ),
                        SizeBoxH12(),
                        InterFontTextWidget(
                          "1000KS",
                          fontWeight: FontWeight.w600,
                          color: GREEN_BUTTON_COLOR,
                          fontSize: NORMAL_FONT_SIZE,
                        ),
                        SizeBoxH12(),
                        Center(
                          child: Container(
                              width: 150,
                              height: 27,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "ADD",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: GREEN_BUTTON_COLOR),
                              )),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: (){
          showModalBottomSheet(context: context , builder: (BuildContext context){
            return Container(
              height: 300,
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsets.all(20.0),
                   height: 200,
                   child: ListView.builder(
                       itemCount: currentFoodItems.length,
                       itemBuilder: (BuildContext context,int index){
                     return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:[ Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children:[
                           Text("${currentFoodItems[index].name}"),
                           SizedBox(width: 50,),
                           Container(
                             height:25,
                             width:25,
                             child: Icon(CupertinoIcons.plus),
                             decoration: BoxDecoration(
                               color:GREEN_BUTTON_COLOR,
                               borderRadius:  BorderRadius.circular(BORDER_RADIUS_CIRCLE)
                             ),


                           ),
                           SizedBox(width: 5,),
                           Text("${currentFoodItems[index].quantity}"),
                           SizedBox(width: 5,),
                           Container(
                             height:25,
                             width:25,
                             child: Icon(CupertinoIcons.minus),
                             decoration: BoxDecoration(
                                 color:GREEN_BUTTON_COLOR,
                                 borderRadius:  BorderRadius.circular(BORDER_RADIUS_CIRCLE)
                             ),


                           ),
                           SizedBox(width: 20,),
                           Text("${currentFoodItems[index].totalPrice}"),


                         ]



                       ),
                         SizeBoxH12()
                         ]
                     );
                   })
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width*0.85,
                   height: 40,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
                     color: GREEN_BUTTON_COLOR,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [Padding(padding: EdgeInsets.only(left: SMALL_PADDING),child: Icon(Icons.fastfood)),Icon(Icons.arrow_drop_up)],
                       ),
                       Row(
                         children: [InterFontTextWidget("10000KS",color: Colors.black,),Icon(Icons.arrow_forward_ios_rounded)],
                       )
                     ],
                   ),
                 ),
               ],
             ),
            );
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width*0.85,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
            color: GREEN_BUTTON_COLOR,
          ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [Padding(padding: EdgeInsets.only(left: SMALL_PADDING),child: Icon(Icons.fastfood)),Icon(Icons.arrow_drop_up)],
            ),
            Row(
              children: [InterFontTextWidget("10000KS",color: Colors.black,),Icon(Icons.arrow_forward_ios_rounded)],
            )
          ],
        ),
        ),
      ),
    );
  }
}
