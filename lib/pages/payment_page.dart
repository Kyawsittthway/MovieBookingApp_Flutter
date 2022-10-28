import 'package:flutter/material.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/data.vos/vos/checkout_snack_vo.dart';
import 'package:movie_booking_app/data.vos/vos/checkout_vo.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/pages/booking_success_page.dart';
import 'package:movie_booking_app/pages/ticket_confirmation_page.dart';
import 'package:movie_booking_app/resources/colors.dart';

import '../common_widgets_view/interfont_text_widget.dart';
import '../data.vos/models/padc_api_model.dart';
import '../data.vos/models/padc_api_model_impl.dart';
import '../data.vos/vos/payment_vo.dart';
import '../models/payment_items.dart';
import '../resources/dimens.dart';
import '../resources/fonts.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PadcApiModel padcApiModel = PadcApiModelImpl();
  List<PaymentVO> paymentList = [];
  GetCheckoutResponse? checkoutResponse;

  void initState(){
    super.initState();

    ///Payment
    // padcApiModel.getPayment(CurrentAppState.userToken).then((payment){
    //   setState(() {
    //     paymentList  = payment;
    //   });
    // }).catchError((error){
    //   print("Error in fetching payment :: $error");
    // });

    /// Payment from database
    padcApiModel.getPaymentsFromDatabase(CurrentAppState.userToken).listen((payments) {
      setState(() {
        paymentList = payments;
        print("Payment List from database :: $paymentList");
      });
    }).onError((error){
      print("Error in fetching payment from database :: $error");
    });

  }
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
          "Payment",
          fontSize: APPBAR_TITLE_FONT_SIZE,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(top:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter your name",
                          hintStyle: TextStyle(
                            color: CINEMA_FEATURES_COLOR,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: GREEN_BUTTON_COLOR)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: GREEN_BUTTON_COLOR),
                          ),
                          labelText: "Your Name",
                          labelStyle: TextStyle(
                            color: GREEN_BUTTON_COLOR,
                          )),
                    ),
                  ),
                  Text(
                    "*",
                    style: (TextStyle(
                      color: Colors.red,
                      fontSize: 20.0
                    )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
                color: GREEN_BUTTON_COLOR,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(AssetImage('assets/icons/unlock_offer.png')),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("Unlock Offer or Apply Promocode")
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left:10),
              child: Text(
                "Choose your payment Type",
                style: TextStyle(
                  color: GREEN_BUTTON_COLOR,
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              height: MediaQuery.of(context).size.height*0.8,
              child: ListView.builder(
                  itemCount: paymentList.length,
                  itemBuilder: (BuildContext context,int index){
                return PaymentListViewItem(paymentItems: paymentList,index: index,respectiveFunction: ()async{
                  CurrentAppState.chosenPaymentId = paymentList[index].id ?? 0;
                  print("Current chosen payment :: ${CurrentAppState.chosenPaymentId}");
                  CheckoutVO checkoutVO = CheckoutVO(CurrentAppState.cinemaDayTimeslotId, CurrentAppState.seatNumber, CurrentAppState.selectedDateForTimeSlot, CurrentAppState.movieId, CurrentAppState.chosenPaymentId, CurrentAppState.currentFoodItems.map((e) => CheckOutSnackVO(e.id, e.quantity)).toList());
                  padcApiModel.checkOut(CurrentAppState.userToken, checkoutVO).then((result) {
                    setState(() {
                      print("Cheeckout Result :: ${result.message}");
                      checkoutResponse = result;
                    });
                  }).catchError((error){
                    print("Error occured in checking out :: $error");
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  TicketConfirmationPage()),
                  );

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

class PaymentListViewItem extends StatelessWidget {
   PaymentListViewItem({
    required this.paymentItems,
     required this.index,
     required this.respectiveFunction,
  });
  final List<PaymentVO> paymentItems;
  int index;
  final Function respectiveFunction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(color:PAYMENT_CONTAINER_BORDER),
          borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              SizedBox(width: 10.0,),
              Image.network("${paymentItems[index].iconPath}",color: Colors.white,),
              SizedBox(width: 5.0,),
              InterFontTextWidget(paymentItems[index].title ?? "")
            ],),
            Icon(Icons.chevron_right,color: Colors.white,)


          ],
        ),
      ),
      onTap: (){
        respectiveFunction();
      },
    );
  }
}
