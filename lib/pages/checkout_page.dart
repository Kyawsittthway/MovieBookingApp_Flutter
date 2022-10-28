import 'dart:ffi';

import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/DashTicketSeperator.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/models/date_time_place_items.dart';
import 'package:movie_booking_app/models/snack_in_cart.dart';
import 'package:movie_booking_app/pages/payment_page.dart';
import 'package:movie_booking_app/resources/colors.dart';

import '../common_widgets_view/button_with_circle_cuts.dart';
import '../common_widgets_view/dart_time_view_section_widget.dart';
import '../common_widgets_view/interfont_text_widget.dart';
import '../resources/dimens.dart';
import '../resources/fonts.dart';
import '../resources/strings.dart';

class CheckOutPage extends StatelessWidget {
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: InterFontTextWidget(
          CHECK_OUT_PAGE_APP_BAR_TITLE,
          fontSize: APPBAR_TITLE_FONT_SIZE,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM,
                  top: MARGIN_MEDIUM),
              //padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        CHECKOUT_PAGE_GRADIENT_COLORR1,
                        CHECKOUT_PAGE_GRADIENT_COLORR2,
                        CHECKOUT_PAGE_GRADIENT_COLORR1
                      ])),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: MARGIN_MEDIUM,
                          right: MARGIN_SMALL,
                          left: MARGIN_SMALL),
                      child: Column(
                        children: [
                          MovieTitleSection(),
                          SizedBox(
                            height: LARGE_HEIGHT,
                          ),
                          MoviePlaceSection(),
                          SizedBox(
                            height: X_HEIGHT,
                          ),
                          DateTimePlaceViewSection(
                            inputDateTimePlace: dateTimePlace,
                          ),
                          SizedBox(
                            height: X_HEIGHT,
                          ),
                          MovieTicketViewSection(),
                        ],
                      ),
                    ),
                    DottedLineMovieSectionView()
                  ],
                ),
              ),
            ),
            SizedBox(
              height: X_HEIGHT,
            ),
            CircleCutButtonWidget(
              onTapFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
              buttonName: CHECKOUT_PAGE_CONTINUE_BUTTON_TEXT, inputColor: GREEN_BUTTON_COLOR,
            ),
            SizedBox(
              height: X_HEIGHT,
            ),
          ],
        ),
      ),
    );
  }
}

class DottedLineMovieSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DottedAndTicketCutWidget(),
          SizedBox(
            height: LARGE_HEIGHT2,
          ),
          SectionTitleWidget(
            sectionTitle: CHECKOUT_PAGE_CONVIENCE_FEE_TEXT,
            price: "500Ks",
            includedIcon: false,
            includedSuffixIcon: true,
          ),
          SizedBox(
            height: LARGE_HEIGHT2,
          ),
          TicketPolicyButtonViewWidget(),
          SizedBox(
            height: LARGE_HEIGHT2,
          ),
          DividerViewWidget(),
          SizedBox(
            height: LARGE_HEIGHT2,
          ),
          TotalAmountViewSection(),
          SizedBox(
            height: X_HEIGHT,
          )
        ],
      ),
    );
  }
}

class TotalAmountViewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InterFontTextWidget(
          CHECKOUT_PAGE_TOTAL_FEE_TEXT,
          fontSize: LARGE_FONT_SIZE,
          color: GREEN_BUTTON_COLOR,
        ),
        SizedBox(
          width: CHECKOUT_PAGE_TOTAL_AMOUNT_VIEW_MARGIN_WIDTH,
        ),
        InterFontTextWidget(
          "${10500 + CurrentAppState.getTotalAmount()} Ks",
          fontSize: LARGE_FONT_SIZE,
          color: GREEN_BUTTON_COLOR,
        )
      ],
    );
  }
}

class DividerViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: LARGE_HEIGHT,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Divider(
          color: DIVIDER_COLOR1,
        ),
      ),
    );
  }
}

class TicketPolicyButtonViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: SMALL_PADDING_13),
        width: CHECKOUT_PAGE_TICKET_POLICY_BUTTON_WIDTH,
        height: X_HEIGHT,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(
              width: MICRO_WIDTH,
            ),
            InterFontTextWidget(
              CHECKOUT_PAGE_TICKET_CANCELLATION_POLICY_TEXT,
              fontSize: SMALL_FONT_SIZE_14,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BORDER_RADIUS_CIRCLE),
          color: TICKET_POLICY_COLOR,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.85,
              padding:EdgeInsets.all(SMALL_PADDING_2X),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
              ),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        InterFontTextWidget("Ticket Cancellation Policy"),
                      ],
                    ),
                    SizedBox(height: SMALL_PADDING),
                    TicketCancellationPolicyTextWithIcons(
                      inputIcon: Icons.fastfood,
                      inputText: REFUND_ON_FNB,
                    ),
                    SizedBox(height: SMALL_PADDING),
                    TicketCancellationPolicyTextWithIcons(
                      inputIcon: Icons.airplane_ticket,
                      inputText: UP_PERCENT_FOR_REFUND,
                    ),
                    SizedBox(height: SMALL_PADDING),
                    Container(

                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TicketCancellationPolicySubheader(
                              inputText:
                                  "-75% refund until 2 hours before show start time"),
                          SizedBox(height: SMALL_PADDING),
                          TicketCancellationPolicySubheader(
                              inputText:
                                  "-50% refund between 2 hours and 20 minutes before show start time"),
                          SizedBox(height: SMALL_PADDING_2X),
                        ],
                      ),
                    ),
                    InterFontTextWidget("1. Refund not available for Convenience fees,Vouchers, Gift Cards, Taxes etc."),
                    SizedBox(height: SMALL_PADDING),
                    InterFontTextWidget("2. No cancellation within 20minute of show start time."),
                    SizedBox(height: SMALL_PADDING_2X),
                    Center(
                      child: Container(
                        width: 350,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: GREEN_BUTTON_COLOR
                          ),
                          child: Text(CLOSE_BUTTON_TEXT,style:TextStyle(
                            color: Colors.black,
                            fontSize: NORMAL_FONT_SIZE_2X,
                          ),),

                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TicketCancellationPolicySubheader extends StatelessWidget {
  TicketCancellationPolicySubheader({required this.inputText});

  final String inputText;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container
        (
        padding: EdgeInsets.only(left:SMALL_PADDING_2X),
        width: MediaQuery.of(context).size.width*0.75,
        child: Text(
          inputText,
          maxLines: 2,
          style: TextStyle(
            color: DIVIDER_COLOR,
            fontSize: SMALL_FONT_SIZE_14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ]);
  }
}

class TicketCancellationPolicyTextWithIcons extends StatelessWidget {
  TicketCancellationPolicyTextWithIcons(
      {required this.inputIcon, required this.inputText});

  final IconData inputIcon;
  final String inputText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          inputIcon,
          color: Colors.white,
        ),
        SizedBox(
          width: SMALL_PADDING,
        ),
        Text(
          inputText,
          style: TextStyle(
            color: Colors.white,
            fontSize: NORMAL_FONT_SIZE_2X,
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}

class DottedAndTicketCutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DashedTicketSeparator(),
    );
  }
}

class MovieTicketViewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.only(left: SMALL_PADDING_12),
        child: InterFontTextWidget(
          "M-Ticket(1)",
          fontSize: SMALL_FONT_SIZE_14,
        ),
      ),
      SizedBox(
        height: LARGE_HEIGHT,
      ),
      TicketAmountViewSection(),
      Center(
        child: Container(
          height: LARGE_HEIGHT,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Divider(
            color: DIVIDER_COLOR1,
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitleWidget(
            sectionTitle: CHECKOUT_PAGE_FNB_SECTION_TEXT,
            price: "${CurrentAppState.getTotalAmount()}",
            includedIcon: true,
            includedSuffixIcon: false,
          ),
          SizedBox(
            height: LARGE_HEIGHT,
          ),
          FoodAndBeverageReceiptItemView(),
          SizedBox(
            height: LARGE_HEIGHT2,
          ),
        ],
      )
    ]);
  }
}

class FoodAndBeverageReceiptItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: XXXL_HEIGHT*(CurrentAppState.currentFoodItems.length/2.5),
      padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING_13),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: CurrentAppState.currentFoodItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              FoodItemRowWidget(snack: CurrentAppState.currentFoodItems[index],),
              SizedBox(
                height: LARGE_HEIGHT,
              )
            ]);
          }),
    );
  }
}

class FoodItemRowWidget extends StatelessWidget {
   FoodItemRowWidget({
    required this.snack
  });
  final SnackInCart snack;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FoodItemAndQuantityWidget(snackInCart: snack,),
        InterFontTextWidget(
          "${snack.getTotalPrice()}",
          fontSize: SMALL_FONT_SIZE_14,
          color: DIVIDER_COLOR1,
        ),
      ],
    );
  }
}

class TicketAmountViewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: XXL_HEIGHT,
      child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InterFontTextWidget(
                  "${CurrentAppState.seatNumber}",
                ),
                SizedBox(
                  width: 200.0,
                ),
                InterFontTextWidget("10000 Ks")
              ],
            );
          }),
    );
  }
}

class MoviePlaceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InterFontTextWidget(CurrentAppState.receipt.cinemaName ?? "", color: GREEN_BUTTON_COLOR),
        SizedBox(
          width: CHECKOUT_PAGE_MOVIE_PLACE_SECTION_WIDTH,
        ),
        InterFontTextWidget("(SCREEN 2)")
      ],
    );
  }
}

class MovieTitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.65,
            child: InterFontTextWidget(CurrentAppState.receipt.movieName ?? "")),
        SizedBox(
          width: CHECKOUT_PAGE_MOVIE_PLACE_SECTION_WIDTH,
        ),
        InterFontTextWidget("(3D)(U/A)"),
      ],
    );
  }
}

class FoodItemAndQuantityWidget extends StatelessWidget {
  FoodItemAndQuantityWidget({
    required this.snackInCart
});
final SnackInCart snackInCart;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            color: GREEN_BUTTON_COLOR,
            height: CHECKOUT_PAGE_FOOD_AND_QUANTITY_WIDGET_HEIGHT,
            width: CHECKOUT_PAGE_FOOD_AND_QUANTITY_WIDGET_WIDTH,
            child: Center(
              child: Icon(
                Icons.close_sharp,
                size: 15,
              ),
            ),
          ),
          onTap: () {},
        ),
        SizedBox(
          width: MICRO_WIDTH,
        ),
        InterFontTextWidget(
          "${snackInCart.snackName}(Qt.${snackInCart.quantity})",
          fontSize: SMALL_FONT_SIZE_14,
          color: DIVIDER_COLOR1,
        ),
      ],
    );
  }
}

class SectionTitleWidget extends StatelessWidget {
  SectionTitleWidget(
      {required this.sectionTitle,
      required this.price,
      required this.includedIcon,
      required this.includedSuffixIcon});

  final String sectionTitle;
  final String price;
  final bool includedIcon;
  final bool includedSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: SMALL_PADDING, left: SMALL_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Visibility(
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.white,
                    ),
                    visible: includedIcon,
                  ),
                  SizedBox(
                    width: MICRO_WIDTH,
                  ),
                  InterFontTextWidget(sectionTitle),
                ],
              ),
              Visibility(
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.white,
                ),
                visible: includedSuffixIcon,
              ),
            ],
          ),
          InterFontTextWidget(price),
        ],
      ),
    );
  }
}
