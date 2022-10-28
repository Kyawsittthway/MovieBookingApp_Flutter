import 'package:flutter/cupertino.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_by_date_vo.dart';
import 'package:movie_booking_app/data.vos/vos/config_vo.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/get_otp_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../network/responses/get_banners_response.dart';
import '../../network/responses/sign_in_with_phone_response.dart';
import '../vos/base_response_vo.dart';
import '../vos/checkout_vo.dart';
import '../vos/cinema_time_slot_status_vo.dart';
import '../vos/cinema_vo.dart';
import '../vos/city_vo.dart';
import '../vos/payment_vo.dart';
import '../vos/seat_vo.dart';
import '../vos/snack_category_vo.dart';
import '../vos/snack_vo.dart';


abstract class PadcApiModel{
  /// Network
  Future<GetOTPResponse> getOTPResponse(String phoneNo);
  void getSignInWithPhoneResponse(String phoneNo,String otp);
  Future<List<BannerImageVO>> getBannersResponse();
  Future<HttpResponse> getConfigResponse();
  void getCinemaAndShowtimeByDate(String token,String selectedDate);
  Future<List<CinemaVO>> getCinema();
  Future<GetCheckoutResponse> checkOut(String token, CheckoutVO checkOutVO);
  Future<List<SnackVO>> getAllSnack(String token);
  void getSnacksByCategoryID(String token, int categoryId);
  Future<List<SeatVO>> getSeatingPlan(String token, int cinemaDayTimeslotId, String bookingDate);
  void getSnackCategories(String token);
  void getPayment(String token);
  Future<BaseResponseVO> signInWithGoogle(String accessToken, String name);
  Future<List<CityVO>> getCities();
  Future<BaseResponseVO> setCities(String accessToken,int cityId);


  ///Database
  Stream<SignInWithPhoneResponse?> getUserInfoFromDatabase(String phoneNo,String otp);
  Future<SignInWithPhoneResponse?> getUserInfoFromDatabaseNoParameter();
  Future<List<BannerImageVO>>  getBannersResponseFromDatabase();
  Future<List<CinemaVO>> getCinemasFromDatabase();
  Future<ConfigVO> getConfigByDateKeyFromDatabase(String dateKey);
  Future<List<CinemaTimeslotVO>> getCinemaTimeslotsByDateKeyFromDatabase(String selectedDate);
  Stream<List<CinemaByDateVO>?> getCinemaAndShowtimeByDateFromDatabase(String selectedDate,String token);
  Stream<List<SnackCategoryVO>> getSnackCategoriesFromDatabase(String token);
  Stream<List<SnackVO>?> getSnacksByCategoryIDFromDatabase(int categoryId,String token);
  Stream<List<PaymentVO>> getPaymentsFromDatabase(String token);
}