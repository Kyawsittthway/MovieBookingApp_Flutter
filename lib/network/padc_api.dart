import 'package:dio/dio.dart';
import 'package:movie_booking_app/data.vos/vos/checkout_response_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/network/responses/get_banners_response.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_and_showtime_by_date_response.dart';
import 'package:movie_booking_app/network/responses/get_cinema_response.dart';
import 'package:movie_booking_app/network/responses/get_config_response.dart';
import 'package:movie_booking_app/network/responses/get_otp_response.dart';
import 'package:movie_booking_app/network/responses/get_snack_categories_response.dart';
import 'package:movie_booking_app/network/responses/get_snack_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:retrofit/retrofit.dart';

import '../data.vos/vos/base_response_vo.dart';
import '../data.vos/vos/checkout_vo.dart';
import 'responses/get_city_response.dart';
import 'responses/get_payment_response.dart';
import 'responses/get_seating_plan_response.dart';

part 'padc_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class PADCapi{
  factory PADCapi(Dio dio) = _PADCapi;

  @POST(ENDPOINT_GET_OTP)
  Future<GetOTPResponse> getOTPResponse(
      @Field("phone") String phoneNo
      );

  @POST(ENDPOINT_CHECK_OTP)
  Future<SignInWithPhoneResponse> getSignInWithPhoneResponse(
      @Field("phone") String phoneNo,
      @Field("otp") String otp
      );

  @GET(ENDPOINT_GET_BANNERS)
  Future<GetBannersResponse> getBannersResponse(
      );

  @GET(ENDPOINT_GET_CONFIGS)
  Future<HttpResponse> getConfigResponse();

  @GET(ENDPOINT_GET_CINEMA_AND_SHOWTIME_BY_DATE)
  Future<GetCinemaAndShowtimeByDateResponse> getCinemaAndShowtimeByDate(
      @Query("date") String date,
      @Header("Authorization") String token
      );

  @GET(ENDPOINT_GET_CINEMA)
  Future<GetCinemaResponse> getCinema();

  @POST(ENDPOINT_CHECKOUT)
  Future<GetCheckoutResponse> checkOut(
      @Header("Authorization") String token,
      @Body() CheckoutVO checkOutVO
      );

  @GET(ENDPOINT_GET_SNACKS)
  Future<GetSnackResponse> getAllSnack(
      @Header("Authorization") String token
      );

  @GET(ENDPOINT_GET_SNACKS)
  Future<GetSnackResponse> getSnacksByCategoryID(
      @Header("Authorization") String token,
      @Query("category_id") int categoryId
      );

  @GET(ENDPOINT_GET_SEATING_PLAN)
  Future<GetSeatingPlanResponse> getSeatingPlan(
      @Header("Authorization") String token,
      @Query("cinema_day_timeslot_id") int cinemaDayTimeslotId,
      @Query("booking_date")String bookingDate
      );

  @GET(ENDPOINT_GET_SNACK_CATEGORY)
  Future<GetSnackCategoriesResponse> getSnackCategories(
      @Header("Authorization") String token
      );

  @GET(ENDPOINT_GET_PAYMENTTYPE)
  Future<GetPaymentResponse> getPayment(
      @Header("Authorization") String token
      );

  @POST(ENDPOINT_SIGN_IN_WITH_GOOGLE)
  Future<BaseResponseVO> signInWithGoogle(
      @Field('access-token') String accessToken,
      @Field("name") String name
      );

  @GET(ENDPOINT_GET_CITY)
  Future<GetCityResponse> getCities(

      );

  @POST(ENDPOINT_SET_CITY)
  Future<BaseResponseVO> setCities(
      @Header("Authorization") String token,
      @Field('city_id') int cityId
      );

}

