
import 'package:json_annotation/json_annotation.dart';

import 'checkout_snack_vo.dart';


part 'checkout_vo.g.dart';


@JsonSerializable()
class CheckoutVO{

  @JsonKey(name:'cinema_day_timeslot_id')
  int? cinemaDayTimeslotId;

  @JsonKey(name:'seat_number')
  String? seatNumber;

  @JsonKey(name:'booking_date')
  String? bookingDate;

  @JsonKey(name:'movie_id')
  int? movieId;

  @JsonKey(name:'payment_type_id')
  int? paymentTypeId;

  @JsonKey(name:'snacks')
  List<CheckOutSnackVO>? snacks;

  CheckoutVO(this.cinemaDayTimeslotId, this.seatNumber, this.bookingDate,
      this.movieId, this.paymentTypeId, this.snacks);

  factory CheckoutVO.fromJson(Map<String,dynamic>json)=>_$CheckoutVOFromJson(json);

  Map<String,dynamic>toJson()=>_$CheckoutVOToJson(this);
}


// {
// "cinema_day_timeslot_id": 25,
// "seat_number": "G-8",
// "booking_date": "2022-02-19",
// "movie_id": 616037,
// "payment_type_id": 1,
// "snacks": [
// {
// "id": 1,
// "quantity": 2
// },
// {
// "id": 3,
// "quantity": 3
// }
// ]
// }