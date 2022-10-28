import 'package:flutter/cupertino.dart';

class PaymentItems{
  final ImageProvider iconData;
  final String paymentName;
  PaymentItems({
    required this.iconData,
    required this.paymentName
});
}
List<PaymentItems> paymentItems = [
  PaymentItems(iconData: AssetImage("assets/icons/upi.png"), paymentName: "UPI"),
  PaymentItems(iconData: AssetImage("assets/icons/gift_card.png"), paymentName: "Gift Vouncher"),
  PaymentItems(iconData: AssetImage("assets/icons/quick_pay.png"), paymentName: "Quick Pay"),
  PaymentItems(iconData: AssetImage("assets/icons/creditCard.png"), paymentName: "Credit Card/ Debit Card"),
  PaymentItems(iconData: AssetImage("assets/icons/redeem_point.png"), paymentName: "Redeem Point"),
  PaymentItems(iconData: AssetImage("assets/icons/mobile_wallet.png"), paymentName: "Mobile Wallet"),
  PaymentItems(iconData: AssetImage("assets/icons/net_banking.png"), paymentName: "Net Banking")
];