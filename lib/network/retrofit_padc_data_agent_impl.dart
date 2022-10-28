import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';
import 'package:movie_booking_app/data.vos/vos/checkout_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_by_date_vo.dart';
import 'package:movie_booking_app/data.vos/vos/city_vo.dart';
import 'package:movie_booking_app/data.vos/vos/config_vo.dart';
import 'package:movie_booking_app/data.vos/vos/payment_vo.dart';
import 'package:movie_booking_app/data.vos/vos/seat_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_category_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_vo.dart';
import 'package:movie_booking_app/network/padc_api.dart';
import 'package:movie_booking_app/network/padc_api_data_agent.dart';
import 'package:movie_booking_app/network/responses/get_banners_response.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_and_showtime_by_date_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_response.dart';
import 'package:movie_booking_app/network/responses/get_config_response.dart';
import 'package:movie_booking_app/network/responses/get_otp_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:retrofit/retrofit.dart';

import '../data.vos/vos/cinema_vo.dart';

class RetrofitPADCDataAgentImpl extends PADCdataAgent {
  late PADCapi padcAPI;
  static final RetrofitPADCDataAgentImpl _singleton =
      RetrofitPADCDataAgentImpl._internal();

  factory RetrofitPADCDataAgentImpl() {
    return _singleton;
  }

  RetrofitPADCDataAgentImpl._internal() {
    const HEADER_REQUESTED_WITH = "X-Requested-With";
    const String XML_HTTP_REQUEST = "XMLHttpRequest";
    final dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          HEADER_REQUESTED_WITH: XML_HTTP_REQUEST,
        },
      ),
    );


    padcAPI = PADCapi(dio);
  }

  @override
  Future<GetOTPResponse> getOTPResponse(String phoneNo) {
    return padcAPI
        .getOTPResponse(phoneNo)
        .asStream()
        .map((getOTPResponse) => getOTPResponse)
        .first;
  }

  @override
  Future<SignInWithPhoneResponse> getSignInWithPhoneResponse(
      String phoneNo, String otp) {
    return padcAPI
        .getSignInWithPhoneResponse(phoneNo, otp)
        .asStream()
        .map((getSignInWithPhoneResponse) => getSignInWithPhoneResponse)
        .first;
  }

  @override
  Future<List<BannerImageVO>> getBannersResponse() {
    return padcAPI
        .getBannersResponse()
        .asStream()
        .map((bannerResponse) => bannerResponse.data ?? [])
        .first;
  }

  @override
  Future<List<CinemaVO>> getCinema() {
    return padcAPI
        .getCinema()
        .asStream()
        .map((cinema) => cinema.data ?? [])
        .first;
  }

  @override
  Future<List<CinemaByDateVO>> getCinemaAndShowtimeByDate(String selectedDate,String token,) {
    print("Data agent (selected date) ${selectedDate} and Token ${token}");
    return padcAPI
        .getCinemaAndShowtimeByDate(selectedDate,token)
        .asStream()
        .map((cinemas) => cinemas.data ?? [])
        .first;
  }

  @override
  Future<HttpResponse> getConfigResponse() {
    return padcAPI.getConfigResponse();
  }

  @override
  Future<List<SnackVO>> getAllSnack(String token) {
    return padcAPI
        .getAllSnack(token)
        .asStream()
        .map((response) => response.snacks ?? [])
        .first;
  }

  @override
  Future<List<CityVO>> getCities() {
    return padcAPI
        .getCities()
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<PaymentVO>> getPayment(String token) {
    return padcAPI
        .getPayment(token)
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<SeatVO>> getSeatingPlan(
      String token, int cinemaDayTimeslotId, String bookingDate) {
    return padcAPI
        .getSeatingPlan(token, cinemaDayTimeslotId, bookingDate)
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<SnackCategoryVO>> getSnackCategories(String token) {
    return padcAPI
        .getSnackCategories(token)
        .asStream()
        .map((response) => response.snackCategories ?? [])
        .first;
  }

  @override
  Future<List<SnackVO>> getSnacksByCategoryID(String token, int categoryId) {
    return padcAPI
        .getSnacksByCategoryID(token, categoryId)
        .asStream()
        .map((response) => response.snacks ?? [])
        .first;
  }

  @override
  Future<GetCheckoutResponse> checkOut(String token, CheckoutVO checkOutVO) {
    return padcAPI
        .checkOut(token, checkOutVO)
        .asStream()
        .map((response) => response)
        .first;
  }

  @override
  Future<BaseResponseVO> signInWithGoogle(String accessToken, String name) {
    return signInWithGoogle(accessToken, name)
          .asStream()
          .map((response) => response)
          .first;
  }

  @override
  Future<BaseResponseVO> setCities(String accessToken,int cityId) {
    return padcAPI
          .setCities(accessToken,cityId)
          .asStream()
          .map((result) => result)
          .first;
  }


}
