
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/checkout_response_snack_vo.dart';
import 'package:movie_booking_app/data.vos/vos/checkout_timeslot_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_vo.dart';
import 'package:movie_booking_app/data.vos/vos/timeslot_vo.dart';

part 'checkout_response_vo.g.dart';

@JsonSerializable()
class CheckoutResponseVO{

  @JsonKey(name:'id')
  int? id;

  @JsonKey(name:'booking_no')
  String? bookingNo;

  @JsonKey(name:'booking_date')
  String? bookingDate;

  @JsonKey(name:'row')
  String? row;

  @JsonKey(name:'seat')
  String? seat;

  @JsonKey(name:'total_seat')
  int? totalSeat;

  @JsonKey(name:'total')
  String? total;

  @JsonKey(name:'movie_id')
  int? movieId;

  @JsonKey(name:'cinema_id')
  int? cinemaId;

  @JsonKey(name:'username')
  String? userName;

  @JsonKey(name:'timeslot')
  CheckoutTimeslotVO? timeslot;

  @JsonKey(name:'snacks')
  List<CheckoutResponseSnackVO>? snacks;

  @JsonKey(name:'qr_code')
  String? qrCode;

  CheckoutResponseVO(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movieId,
      this.cinemaId,
      this.userName,
      this.timeslot,
      this.snacks,
      this.qrCode);

  factory CheckoutResponseVO.fromJson(Map<String,dynamic>json)=>_$CheckoutResponseVOFromJson(json);

  Map<String,dynamic>toJson()=>_$CheckoutResponseVOToJson(this);

}

// "id": 2204,
// "booking_no": "JCTV-3778-7086",
// "booking_date": "2022-03-25",
// "row": "G",
// "seat": "G-1",
// "total_seat": 1,
// "total": "$19",
// "movie_id": 616037,
// "cinema_id": 2,
// "username": "Kyaw Sitt Thway",
// "timeslot": {
// "cinema_day_timeslot_id": 25,
// "start_time": "10:00 AM"
// },
// "snacks": [
// {
// "id": 4191,
// "name": "Burger Combo1",
// "description": "Et dolores eaque officia aut.",
// "image": "https://storage.googleapis.com/mmds-padc/PADC/tmba/snacks/burger.jpeg",
// "price": 2,
// "unit_price": 2,
// "quantity": 2,
// "total_price": 4
// },
// {
// "id": 4192,
// "name": "PopCorn",
// "description": "At vero et doloribus sint porro ipsum consequatur.",
// "image": "https://storage.googleapis.com/mmds-padc/PADC/tmba/snacks/popcorn.webp",
// "price": 4,
// "unit_price": 4,
// "quantity": 3,
// "total_price": 12
// }
// ],
// "qr_code": "uploads/img/qr-code/img-JCTV-3778-7086.png"
