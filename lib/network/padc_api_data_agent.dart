import 'package:flutter/cupertino.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_by_date_vo.dart';
import 'package:movie_booking_app/data.vos/vos/config_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_vo.dart';
import 'package:movie_booking_app/network/responses/get_banners_response.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_and_showtime_by_date_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_response.dart';
import 'package:movie_booking_app/network/responses/get_config_response.dart';
import 'package:movie_booking_app/network/responses/get_otp_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:retrofit/retrofit.dart';

import '../data.vos/vos/base_response_vo.dart';
import '../data.vos/vos/checkout_vo.dart';
import '../data.vos/vos/cinema_vo.dart';
import '../data.vos/vos/city_vo.dart';
import '../data.vos/vos/payment_vo.dart';
import '../data.vos/vos/seat_vo.dart';
import '../data.vos/vos/snack_category_vo.dart';

abstract class PADCdataAgent{
  Future<GetOTPResponse> getOTPResponse(String phoneNo);
  Future<SignInWithPhoneResponse>getSignInWithPhoneResponse(String phoneNo,String otp);
  Future<List<BannerImageVO>> getBannersResponse();
  Future<HttpResponse> getConfigResponse();
  Future<List<CinemaByDateVO>> getCinemaAndShowtimeByDate(String token,String selectedDate);
  Future<List<CinemaVO>> getCinema();
  Future<GetCheckoutResponse> checkOut(String token, CheckoutVO checkOutVO);
  Future<List<SnackVO>> getAllSnack(String token);
  Future<List<SnackVO>> getSnacksByCategoryID(String token, int categoryId);
  Future<List<SeatVO>> getSeatingPlan(String token, int cinemaDayTimeslotId, String bookingDate);
  Future<List<SnackCategoryVO>> getSnackCategories(String token);
  Future<List<PaymentVO>> getPayment(String token);
  Future<BaseResponseVO> signInWithGoogle(String accessToken, String name);
  Future<List<CityVO>> getCities();
  Future<BaseResponseVO> setCities(String accessToken,int cityId);
}