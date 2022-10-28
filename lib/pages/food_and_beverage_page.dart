import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/data.vos/vos/snack_category_vo.dart';
import 'package:movie_booking_app/models/food_items.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';

import '../data.vos/models/padc_api_model.dart';
import '../data.vos/models/padc_api_model_impl.dart';
import '../data.vos/vos/snack_vo.dart';
import '../models/snack_in_cart.dart';
import 'checkout_page.dart';

class FoodAndBeveragePage extends StatefulWidget {


  @override
  _FoodAndBeveragePageState createState() => _FoodAndBeveragePageState();
}

class _FoodAndBeveragePageState extends State<FoodAndBeveragePage> {
  List<SnackCategoryVO> foodCategory = [SnackCategoryVO(0, "All", "All", 1, "", "", "")];
  List<SnackVO> snackByCategoryList = [];

  PadcApiModel padcApiModel = PadcApiModelImpl();

  void initState(){
    super.initState();
    ///Get Snack Categories
    // padcApiModel.getSnackCategories(CurrentAppState.userToken).then((result){
    //   setState(() {
    //     foodCategory.addAll(result);
    //
    //     _getSnackByCategoryAndRefresh(foodCategory.first.id ?? 0);
    //     print("Result in food category :: $foodCategory");
    //
    //   });
    // }).catchError((error){
    //   print("Error in fetching snack categories :: ${error}");
    // });

    ///Get Snack Categories from Database
    padcApiModel.getSnackCategoriesFromDatabase(CurrentAppState.userToken).listen((result){
      setState(() {
        foodCategory.clear();
        foodCategory.add(SnackCategoryVO(0, "All", "All", 1, "", "", ""));
        foodCategory.addAll(result as List<SnackCategoryVO>);
        _getSnackByCategoryAndRefresh(foodCategory.first.id ?? 0);
        print("Result in food category database :: $foodCategory");

      });
    }).onError((error){
      print("Error fetching snack category from database :: $error");
    });

  }



  void _getSnackByCategoryAndRefresh(int? categoryId){

  // /// Get Snack by SnackCategoryId
  //   padcApiModel.getSnacksByCategoryID(CurrentAppState.userToken,categoryId ?? 0).then((snackByCategory){
  //     setState(() {
  //       snackByCategoryList = snackByCategory;
  //     });
  //   }).catchError((error){
  //     debugPrint(error.toString());
  //   });

    /// Get Snack By SnackCategoryId from database
    padcApiModel.getSnacksByCategoryIDFromDatabase(categoryId ?? 0,CurrentAppState.userToken).listen((snackByCategory){
      setState(() {
        snackByCategoryList = snackByCategory ?? [];
        print("snackByCategoryList db :: $snackByCategoryList");
      });
    }).onError((error){
      print("Error fetching get snack  by snackcategory from database :: $error");
    });

  }

  @override
  Widget build(BuildContext context) {
    var rootContext = this.context;
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: MEDIUM_ICON_SIZE,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: InterFontTextWidget(
          FOOD_AND_BEVERAGES_APP_BAR_TITLE_TEXT,
          fontSize: APPBAR_TITLE_FONT_SIZE,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          Padding(
              padding: EdgeInsets.only(right: SMALL_PADDING),
              child: TextButton(
                  onPressed: () {},
                  child: InterFontTextWidget(FOOD_AND_BEVERAGES_SKIP_BUTTON_TEXT,
                      fontSize: APPBAR_TEXT_BUTTON_FONT_SIZE)))
        ],
      ),
      body: Column(
        children: [
          TabBarViewSection(
            foodCategory: foodCategory,
            onTapCategory: (categoryId )=>_getSnackByCategoryAndRefresh(categoryId)),
          FoodItemsGridViewSection(snackByCategory: snackByCategoryList,root: rootContext,)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(BORDER_RADIUS_CIRCLE),
                          topRight: Radius.circular(BORDER_RADIUS_CIRCLE)),
                      color: PRIMARY_BACKGROUND_COLOR),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(20.0),
                          height: 110,
                          child: ListView.builder(
                              itemCount: CurrentAppState.currentFoodItems.isEmpty ? 0 : CurrentAppState.currentFoodItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ModalListItemsWidget(currentFoodItems: CurrentAppState.currentFoodItems.isEmpty ? [] :CurrentAppState.currentFoodItems,index: index,root: rootContext,),
                                      SizeBoxH12()
                                    ],);
                              },),),
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(BORDER_RADIUS_NORMAL),
                            color: GREEN_BUTTON_COLOR,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              bottomStatusBar(currentFoodItems: CurrentAppState.currentFoodItems),
                              Row(
                                children: [
                                  InterFontTextWidget(
                                    "${CurrentAppState.getTotalAmount()} KS",
                                    color: Colors.black,
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded)
                                ],
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutPage()),
                          );
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
            color: GREEN_BUTTON_COLOR,
          ),
          child: FirstScreenBottomStatusBar(UniqueKey()),
        ),
      ),
    );
  }
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }
}

class FirstScreenBottomStatusBar extends StatefulWidget {
   FirstScreenBottomStatusBar(
       this.orderKey
  ):super(key:orderKey);
  final Key orderKey;

  @override
  State<FirstScreenBottomStatusBar> createState() => _FirstScreenBottomStatusBarState();
}

class _FirstScreenBottomStatusBarState extends State<FirstScreenBottomStatusBar> {
  List<SnackInCart>currentFoodItems = [];
  @override
  void initState(){
    super.initState();
    setState((){
      currentFoodItems = CurrentAppState.currentFoodItems;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: SMALL_PADDING),
                child: Badge(
                  badgeContent:Text(currentFoodItems.length.toString()),
                  child: Icon(Icons.fastfood),),
            ),
            Icon(Icons.arrow_drop_up)
          ],
        ),
        Row(
          children: [
            InterFontTextWidget(
              "${CurrentAppState.getTotalAmount()} KS",
              color: Colors.black,
            ),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        )
      ],
    );
  }
}

class bottomStatusBar extends StatefulWidget {
   bottomStatusBar({
    required this.currentFoodItems,
  }) ;

  final List<SnackInCart> currentFoodItems;

  @override
  State<bottomStatusBar> createState() => _bottomStatusBarState();
}

class _bottomStatusBarState extends State<bottomStatusBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding:
                EdgeInsets.only(left: SMALL_PADDING),
            child: Badge(
                badgeContent:Text(CurrentAppState.currentFoodItems.length.toString()),
                child: Icon(Icons.fastfood),),),
        Icon(Icons.arrow_drop_down)
      ],
    );
  }
}

class ModalListItemsWidget extends StatefulWidget {
   ModalListItemsWidget({
    required this.index,
    required this.currentFoodItems,
     required this.root,
  }) ;

  final List<SnackInCart> currentFoodItems;
  final int index;
  final String totalPrice = "";
  final BuildContext root;
  @override
  State<ModalListItemsWidget> createState() => _ModalListItemsWidgetState();
}

class _ModalListItemsWidgetState extends State<ModalListItemsWidget> {

  @override
  Widget build(BuildContext context) {
    var modalListRootContext = this.context;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          Container(
            width: KILO_WIDTH,
            child: InterFontTextWidget(
              "${widget.currentFoodItems[widget.index].snackName}",
              fontSize: SMALL_FONT_SIZE_14,
              fontWeight: FontWeight.w600,
            ),
          ),
          QuantityAddAndMinusSection(currentFoodItems: widget.currentFoodItems,modalRoot:modalListRootContext,index: widget.index, mainRoot:widget.root,),
          InterFontTextWidget(
            "${widget.currentFoodItems[widget.index].getTotalPrice()} KS",
            fontSize: SMALL_FONT_SIZE_14,
            fontWeight: FontWeight.w600,
          ),
        ],);
  }

}

class QuantityAddAndMinusSection extends StatefulWidget {
   QuantityAddAndMinusSection({
    required this.currentFoodItems,
     required this.modalRoot,
     required this.mainRoot,
    required this.index
  });

  final List<SnackInCart> currentFoodItems;
  BuildContext modalRoot;
  BuildContext mainRoot;
  int index;

  @override
  State<QuantityAddAndMinusSection> createState() => _QuantityAddAndMinusSectionState();
}

class _QuantityAddAndMinusSectionState extends State<QuantityAddAndMinusSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          child:
              IconButton(icon:Icon(CupertinoIcons.plus,size: 10,),onPressed: (){
                setState((){
                  widget.currentFoodItems[widget.index].addItem();
                  (widget.modalRoot as Element).reassemble();
                  (widget.mainRoot as Element).reassemble();
                });

                //print("Quantity ${widget.currentFoodItems[widget.index].quantity}");
              },),
          decoration: BoxDecoration(
              color: GREEN_BUTTON_COLOR,
              borderRadius:
                  BorderRadius.circular(
                      BORDER_RADIUS_CIRCLE)),
        ),
        SizedBox(
          width: 5,
        ),
        InterFontTextWidget(
          "${widget.currentFoodItems[widget.index].quantity}",

          fontSize: SMALL_FONT_SIZE_14,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          height: 25,
          width: 25,
          child: IconButton(
              icon:Icon(CupertinoIcons.minus,size: 10,),onPressed: (){
            setState((){
              widget.currentFoodItems[widget.index].reduceItem();
              (widget.modalRoot as Element).reassemble();
              (widget.mainRoot as Element).reassemble();
            });
          },),
          decoration: BoxDecoration(
              color: GREEN_BUTTON_COLOR,
              borderRadius:
                  BorderRadius.circular(
                      BORDER_RADIUS_CIRCLE)),
        ),
      ],
    );
  }
}

class FoodItemsGridViewSection extends StatefulWidget {
   FoodItemsGridViewSection({
     required this.snackByCategory,
     required this.root
  });
  final List<SnackVO> snackByCategory;
  BuildContext root;

  @override
  State<FoodItemsGridViewSection> createState() => _FoodItemsGridViewSectionState();
}

class _FoodItemsGridViewSectionState extends State<FoodItemsGridViewSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.68,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.8),
          ),
          itemCount: widget.snackByCategory.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 100,
              height: 95,
              margin: EdgeInsets.all(SMALL_PADDING),
              padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
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
                      child: Image.network(
                        widget.snackByCategory[index].imagePath ?? "",
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                  SizeBoxH12(),
                  InterFontTextWidget(
                    widget.snackByCategory[index].name ?? "",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: NORMAL_FONT_SIZE,
                  ),
                  SizeBoxH12(),
                  InterFontTextWidget(
                    widget.snackByCategory[index].price.toString() + " KS" ,
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
                          onPressed: () {
                            if(CurrentAppState.currentFoodItems.isEmpty){
                              setState((){
                                CurrentAppState.currentFoodItems
                                    .add(
                                    SnackInCart(
                                        widget.snackByCategory[index].id ?? 0,
                                        widget.snackByCategory[index].name ?? "",
                                        widget.snackByCategory[index].price
                                            ?.toDouble() ?? 0.0
                                    ));
                              });

                            }else{
                              bool isAlreadyContained = false;
                              for(int i =0 ;i<CurrentAppState.currentFoodItems.length;i++){
                                if(widget.snackByCategory[index].id == CurrentAppState.currentFoodItems[i].id){
                                  setState(() {
                                    CurrentAppState.currentFoodItems[i].addItem();
                                    isAlreadyContained = true;
                                  });

                                }
                              }
                              if(isAlreadyContained == true){
                                return;
                              }else{
                                setState(() {
                                  CurrentAppState.currentFoodItems
                                      .add(
                                      SnackInCart(
                                          widget.snackByCategory[index].id ?? 0,
                                          widget.snackByCategory[index].name ?? "",
                                          widget.snackByCategory[index].price
                                              ?.toDouble() ?? 0.0
                                      ));
                                });

                              }

                            }
                            (widget.root as Element).reassemble();
                            print("In cart :: ${CurrentAppState.currentFoodItems}");
                          },
                          child: Text(
                            FOOD_AND_BEVERAGES_ADD_BUTTON_TEXT,
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
    );
  }
}

class TabBarViewSection extends StatelessWidget {
   TabBarViewSection({
     required this.foodCategory,
     required this.onTapCategory
  });

  final List<SnackCategoryVO> foodCategory;
  final Function(int) onTapCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: SMALL_PADDING, horizontal: SMALL_PADDING),
      child: DefaultTabController(
          length: foodCategory.length,
          child: TabBar(
            onTap: (int index){
              onTapCategory(foodCategory[index].id ?? 1);
            },
            isScrollable: true,
            indicatorColor: GREEN_BUTTON_COLOR,
            tabs: foodCategory
                .map((category) => Tab(
                      child: Text(category.title ?? ""),
                    ))
                .toList(),
          )),
    );
  }
}
