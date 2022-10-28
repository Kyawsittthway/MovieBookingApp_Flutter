
import 'package:movie_booking_app/currentAppState.dart';

class SnackInCart{
  int id = 0;
  String snackName = "";
  int quantity = 1;
  double price = 0.0;
  double totalPrice = 0.0;
  SnackInCart(this.id,this.snackName, this.price);

  double? getTotalPrice(){
   return quantity * price;
  }

  void addItem(){
    quantity++;
  }
  void reduceItem(){
    if(quantity > 0){
      quantity--;
    }else if(quantity == 0){
      CurrentAppState.currentFoodItems.removeWhere((element) => element.id == id);
      print(CurrentAppState.currentFoodItems);
    }
  }
}
