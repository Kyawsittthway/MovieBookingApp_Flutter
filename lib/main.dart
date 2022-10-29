import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/data.vos/vos/actor_vo.dart';
import 'package:movie_booking_app/data.vos/vos/base_actor_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_by_date_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_time_slot_status_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_vo.dart';
import 'package:movie_booking_app/data.vos/vos/collection_vo.dart';
import 'package:movie_booking_app/data.vos/vos/config_vo.dart';
import 'package:movie_booking_app/data.vos/vos/config_vo_cinema_time_slot_status_vo.dart';
import 'package:movie_booking_app/data.vos/vos/credit_vo.dart';
import 'package:movie_booking_app/data.vos/vos/facilities_vo.dart';
import 'package:movie_booking_app/data.vos/vos/genre_vo.dart';
import 'package:movie_booking_app/data.vos/vos/movie_vo.dart';
import 'package:movie_booking_app/data.vos/vos/payment_vo.dart';
import 'package:movie_booking_app/data.vos/vos/production_company_vo.dart';
import 'package:movie_booking_app/data.vos/vos/production_country_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_category_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_vo.dart';
import 'package:movie_booking_app/data.vos/vos/spoken_language_vo.dart';
import 'package:movie_booking_app/data.vos/vos/timeslot_vo.dart';
import 'package:movie_booking_app/data.vos/vos/user_info_vo.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/pages/booking_success_page.dart';
import 'package:movie_booking_app/pages/cancel_booking_page.dart';
import 'package:movie_booking_app/pages/checkout_page.dart';
import 'package:movie_booking_app/pages/chose_time_cinema.dart';
import 'package:movie_booking_app/pages/cinema_detail_page.dart';
import 'package:movie_booking_app/pages/food_and_beverage_page.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/pages/location_page.dart';
import 'package:movie_booking_app/pages/login_page.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/pages/movie_search_page.dart';
import 'package:movie_booking_app/pages/otp_page.dart';
import 'package:movie_booking_app/pages/payment_page.dart';
import 'package:movie_booking_app/pages/profile_page.dart';
import 'package:movie_booking_app/pages/search_cinema_page.dart';
import 'package:movie_booking_app/pages/ticket_confirmation_page.dart';
import 'package:movie_booking_app/pages/welcome_page.dart';
import 'package:movie_booking_app/pages/your_ticket_page.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.vos/models/padc_api_model.dart';
import 'data.vos/models/padc_api_model_impl.dart';
import 'data.vos/vos/banner_image_vo.dart';
import 'data.vos/vos/city_vo.dart';
import 'data.vos/vos/user_info_persistence_vo.dart';

void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(SignInResponseAdapter());
  Hive.registerAdapter(UserInfoVOAdapter());
  Hive.registerAdapter(CityVOAdapter());
  Hive.registerAdapter(BannerImageVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(BaseActorVOAdapter());
  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(TimeslotVOAdapter());
  Hive.registerAdapter(CinemaByDateVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(FacilitiesVOAdapter());
  Hive.registerAdapter(SnackCategoryVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(PaymentVOAdapter());
  Hive.registerAdapter(ConfigVOAdapter());
  Hive.registerAdapter(ConfigVOCinemaTimeSlotStatusVOAdapter());
  Hive.registerAdapter(CinemaTimeslotVOAdapter());
  Hive.registerAdapter(UserInfoPersistenceVOAdapter());




  await Hive.openBox<SignInWithPhoneResponse>(BOX_NAME_SIGN_IN_RESPONSE);
  await Hive.openBox<UserInfoVO>(BOX_NAME_USER_INFO_VO);
  await Hive.openBox<CityVO>(BOX_NAME_CITY_VO);
  await Hive.openBox<BannerImageVO>(BOX_NAME_BANNER_IMAGE_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<CollectionVO>(BOX_NAME_COLLECTION_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<ProductionCompanyVO>(BOX_NAME_PRODUCTION_COMPANY_VO);
  await Hive.openBox<ProductionCountryVO>(BOX_NAME_PRODUCTION_COUNTRY_VO);
  await Hive.openBox<SpokenLanguageVO>(BOX_NAME_SPOKEN_LANGUAGE_VO);
  await Hive.openBox<List>(BOX_NAME_CREDIT_VO);
  await Hive.openBox<BaseActorVO>(BOX_NAME_BASE_ACTOR_VO);
  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<TimeslotVO>(BOX_NAME_TIMESLOT_VO);
  await Hive.openBox<List>(BOX_NAME_CINEMA_BY_DATE_VO);
  await Hive.openBox<CinemaVO>(BOX_NAME_CINEMA_VO);
  await Hive.openBox<FacilitiesVO>(BOX_NAME_FACILITIES_VO);
  await Hive.openBox<List>(BOX_NAME_SNACK_VO);
  await Hive.openBox<SnackCategoryVO>(BOX_NAME_SNACK_CATEGORY_VO);
  await Hive.openBox<PaymentVO>(BOX_NAME_PAYMENT_VO);
  await Hive.openBox<ConfigVO>(BOX_NAME_CONFIG_VO);
  await Hive.openBox<ConfigVoCinemaTimeSlotStatusVO>(BOX_NAME_CONFIG_VO_TIMESLOT_VO);
  await Hive.openBox<List<CinemaTimeslotVO>>(BOX_NAME_CINEMA_TIMESLOT_VO);
  await Hive.openBox<UserInfoPersistenceVO>(BOX_NAME_USER_INFO_PERSISTENCE_VO);


  bool isLoginned = true;
  PadcApiModel padcApiModel = PadcApiModelImpl();
  UserInfoPersistenceVO? userInfo;
  final prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('userId') ?? 0;
  print("shared preference user Id :: $userId");
  padcApiModel.getUserInfoFromDatabaseNoParameter(userId).listen((info) {

    userInfo = info;
    print("User info from database :: ${userInfo?.token}");
    if(userInfo == null){
      print("u : $userInfo");
      CurrentAppState.isLogged = false;
      runApp( MyApp(isLoginned: CurrentAppState.isLogged,));
    }else{
      print("u  f: $userInfo");
     CurrentAppState.isLogged = true;
     print("current appstae is logged :: ${CurrentAppState.isLogged}");
      runApp( MyApp(isLoginned: CurrentAppState.isLogged,));
    }
  }).onError((error) {
    print("error fetching user info from databsae :: $error");
  });




}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isLoginned}) : super(key: key);
  final bool isLoginned;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("is logged $isLoginned");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: PRIMARY_BACKGROUND_COLOR_LOW_OPACITY),
      ),
      title: 'Flutter Demo',
         home: isLoginned? HomePage(): LoginPage()

    );
  }
}




