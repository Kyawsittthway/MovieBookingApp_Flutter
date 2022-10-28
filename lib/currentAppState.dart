import 'package:movie_booking_app/data.vos/vos/city_vo.dart';

import 'models/snack_in_cart.dart';

class CurrentAppState{
  static bool isLogged = false;
  static bool isNowShowing = false;
  static String selectedDateForTimeSlot = "";
  static String userToken  = "Bearer 14571|Mi19UiuFPlnsYa9kIm3aE6Mf5xZ213kQhZtDEdoX";
  static List<SnackInCart> currentFoodItems = [
  ];
  static Receipt receipt = Receipt();
  static String seatNumber = "L-9";

  static double checkoutTotal = 10500 + getTotalAmount();
  static int  chosenPaymentId = 0;

  static int cinemaDayTimeslotId = 0;
  static int movieId  = 0;
  static String moviePoster = "";
  static int currentCityId = 0;
  static String currentCityname = "";



  static double getTotalAmount(){
    double total = 0;
    for(int i=0;i<CurrentAppState.currentFoodItems.length;i++){
      total += CurrentAppState.currentFoodItems[i].getTotalPrice()!;
   //   print( "JJ::${CurrentAppState.currentFoodItems[i].totalPrice}");

  }
    return total;
}

}

class Receipt {
  String? movieName="";
  String? cinemaName="";
  String? date="",time="",location = "";
  List<SnackInCart>? snacks =[];

}