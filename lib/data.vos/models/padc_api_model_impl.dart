import 'package:movie_booking_app/data.vos/models/padc_api_model.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';
import 'package:movie_booking_app/data.vos/vos/checkout_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_by_date_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_time_slot_status_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_vo.dart';
import 'package:movie_booking_app/data.vos/vos/city_vo.dart';
import 'package:movie_booking_app/data.vos/vos/config_vo.dart';
import 'package:movie_booking_app/data.vos/vos/payment_vo.dart';
import 'package:movie_booking_app/data.vos/vos/seat_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_category_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_vo.dart';
import 'package:movie_booking_app/data.vos/vos/user_info_persistence_vo.dart';
import 'package:movie_booking_app/network/padc_api_data_agent.dart';
import 'package:movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:movie_booking_app/network/responses/get_otp_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/network/retrofit_padc_data_agent_impl.dart';
import 'package:movie_booking_app/persistence/dao/banner_image_dao.dart';
import 'package:movie_booking_app/persistence/dao/cinema_by_date_vo_dao.dart';
import 'package:movie_booking_app/persistence/dao/cinema_dao.dart';
import 'package:movie_booking_app/persistence/dao/cinema_timeslot_dao.dart';
import 'package:movie_booking_app/persistence/dao/config_dao.dart';
import 'package:movie_booking_app/persistence/dao/sign_in_response_dao.dart';
import 'package:movie_booking_app/persistence/dao/snack_category_dao.dart';
import 'package:movie_booking_app/persistence/dao/snack_dao.dart';
import 'package:movie_booking_app/persistence/dao/user_info_dao.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/responses/get_banners_response.dart';
import '../../persistence/dao/payment_dao.dart';
import '../vos/user_info_vo.dart';

class PadcApiModelImpl extends PadcApiModel{

  PADCdataAgent padcDataAgent = RetrofitPADCDataAgentImpl();
  static final PadcApiModelImpl _singleton = PadcApiModelImpl._internal();
  factory PadcApiModelImpl(){
    return _singleton;
  }


  PadcApiModelImpl._internal();

  ///DAOs
  UserInfoDao mUserInfoDao = UserInfoDao();
  SignInResponseDao mSignInResponseDao = SignInResponseDao();
  BannerImageDao mBannerImageDao = BannerImageDao();
  CinemaDao mCinemaDao = CinemaDao();
  ConfigDao mConfigDao = ConfigDao();
  CinemaByDateDao mCinemaByDateDao = CinemaByDateDao();
  CinemaTimeslotDao mCinemaTimeslotDao = CinemaTimeslotDao();
  SnackCategoryDao mSnackCategoryDao = SnackCategoryDao();
  SnackDao mSnackDao = SnackDao();
  PaymentDao mPaymentDao = PaymentDao();
  @override
  Future<GetOTPResponse> getOTPResponse(String phoneNo) {
   return padcDataAgent.getOTPResponse(phoneNo);
  }

  @override
  void getSignInWithPhoneResponse(String phoneNo, String otp) {
   padcDataAgent.getSignInWithPhoneResponse(phoneNo, otp).then((userInfo) async{
    mSignInResponseDao.saveUserInfo(userInfo);
    UserInfoPersistenceVO userInfoPersistenceVO = UserInfoPersistenceVO(userInfo.data?.id,userInfo.token, userInfo.data);
    mUserInfoDao.saveUserInfo(userInfoPersistenceVO);
    return Future.value(userInfo);

  });
  }
  Future<List<BannerImageVO>> getBannersResponse(){
    return padcDataAgent.getBannersResponse().then((banners) async{
      mBannerImageDao.saveAllBannerImages(banners);
      return Future.value(banners);
    });
  }

  @override
  Future<List<CinemaVO>> getCinema() {
     return padcDataAgent.getCinema().then((cinemas) async{
       mCinemaDao.saveAllCinema(cinemas);
       return Future.value(cinemas);
     });
  }

  @override
  void getCinemaAndShowtimeByDate(String selectedDate,String token,) {
    print("getCinemaAndShowtimeByDate parameters :: token = ${token} , selectedDate = ${selectedDate}");
     padcDataAgent.getCinemaAndShowtimeByDate(selectedDate,token).then((cinemasByDates) async{
        mCinemaByDateDao.saveAllCinemaByDate(cinemasByDates, selectedDate);
        return Future.value(cinemasByDates);
    });
  }

  @override
  Future<HttpResponse> getConfigResponse() {
   return  padcDataAgent.getConfigResponse();
  }

  @override
  Future<List<SnackVO>> getAllSnack(String token) {
    return padcDataAgent.getAllSnack(token);
  }

  @override
  Future<List<CityVO>> getCities() {
    return padcDataAgent.getCities();
  }

  @override
  void getPayment(String token) {
     padcDataAgent.getPayment(token).then((payments)async{
      mPaymentDao.saveAllPayments(payments);
      return Future.value(payments);
    });

  }

  @override
  Future<List<SeatVO>> getSeatingPlan(String token, int cinemaDayTimeslotId, String bookingDate) {
    return padcDataAgent.getSeatingPlan(token,cinemaDayTimeslotId,bookingDate);
  }

  @override
  void getSnackCategories(String token) {
     padcDataAgent.getSnackCategories(token).then((categories)async{
      mSnackCategoryDao.saveAllSnackCategories(categories);
      return Future.value(categories);
    });
  }

  @override
  void getSnacksByCategoryID(String token, int categoryId) {
     padcDataAgent.getSnacksByCategoryID(token,categoryId).then((snacks) async{
      mSnackDao.saveSnackByCategoryId(snacks, categoryId);
      return Future.value(snacks);
    });
  }

  @override
  Future<GetCheckoutResponse> checkOut(String token, CheckoutVO checkOutVO) {
    return padcDataAgent.checkOut(token, checkOutVO);
  }

  @override
  Future<BaseResponseVO> signInWithGoogle(String accessToken, String name) {
  return padcDataAgent.signInWithGoogle(accessToken, name);
  }

  @override
  Future<BaseResponseVO> setCities(String accessToken,int cityId) {
    return padcDataAgent.setCities(accessToken,cityId);
  }

  @override
  Stream<SignInWithPhoneResponse?> getUserInfoFromDatabase(String phoneNo,String otp) {
    this.getSignInWithPhoneResponse(phoneNo, otp);
    return mSignInResponseDao
        .getUserInfoBoxEvents()
        .startWith(mSignInResponseDao.getUserInfoStream())
        .map((event) => mSignInResponseDao.getUserInfo());
  }

  Stream<UserInfoPersistenceVO?> getUserInfoFromDatabaseNoParameter(int userId){
    return mUserInfoDao
        .getAllUserInfoEventStream()
        .startWith(mUserInfoDao.getUserInfoStream(userId))
        .map((event) => mUserInfoDao.getUserInfo(userId));
  }

  @override
  Future<List<BannerImageVO>> getBannersResponseFromDatabase() {
    return Future.value(mBannerImageDao.getAllBanners());
  }

  @override
  Future<List<CinemaVO>> getCinemasFromDatabase() {
    return Future.value(mCinemaDao.getAllCinema());
  }

  Stream<List<SnackCategoryVO>> getSnackCategoriesFromDatabase(String token){
    this.getSnackCategories(token);
   return mSnackCategoryDao
       .getSnackCategoryEvents()
       .startWith(mSnackCategoryDao.getAllSnackCategoriesStream())
       .map((event) => mSnackCategoryDao.getAllSnackCategories());
  }

  @override
  Stream<List<CinemaByDateVO>?> getCinemaAndShowtimeByDateFromDatabase(String selectedDate,String token) {
    this.getCinemaAndShowtimeByDate(selectedDate, token);
    return mCinemaByDateDao
        .getAllCinemaByDateWithDateKeyEvents()
        .startWith(mCinemaByDateDao.getAllCinemaByDateWithDateKeyStream(selectedDate))
        .map((event) => mCinemaByDateDao.getAllCinemaByDateWithDatekey(selectedDate));
  }

  @override
  Future<ConfigVO> getConfigByDateKeyFromDatabase(String dateKey) {
    return Future.value(mConfigDao.getConfigByTime(dateKey));
  }

  @override
  Future<List<CinemaTimeslotVO>> getCinemaTimeslotsByDateKeyFromDatabase(String selectedDate) {
    return Future<List<CinemaTimeslotVO>>.value(mCinemaTimeslotDao.getAllCinemaTimeslotByDateKey(selectedDate));
  }

  Stream<List<SnackVO>?> getSnacksByCategoryIDFromDatabase(int categoryId,String token){
    this.getSnacksByCategoryID(token, categoryId);
    return mSnackDao
        .getSnackBoxEvents()
        .startWith(mSnackDao.getSnackByCategoryIdStream(categoryId))
        .map((event) => mSnackDao.getSnackByCategoryId(categoryId));
  }

  Stream<List<PaymentVO>> getPaymentsFromDatabase(String token){
   this.getPayment(token);
   return mPaymentDao
       .getAllPaymentsEvent()
       .startWith(mPaymentDao.getAllPaymentsStream())
       .map((event) => mPaymentDao.getAllPayments());
  }







}