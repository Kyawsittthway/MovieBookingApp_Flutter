import 'dart:ui';

import 'package:movie_booking_app/config/environment_config.dart';

import '../config/config_values.dart';

const PRIMARY_BACKGROUND_COLOR  = Color.fromRGBO(19,19,19,1);
const PRIMARY_BACKGROUND_COLOR_LOW_OPACITY  = Color.fromRGBO(19,19,19,0.5);
const HOMEPAGE_APP_BAR_COLOR = Color.fromRGBO(17, 17, 17, 1);

const DIVIDER_COLOR1 =Color.fromRGBO (136, 136, 136, 1);
const DOTTED_LINE_COLOR1 =Color.fromRGBO(68, 68, 68, 1);
///Login Page
///rgba(0, 255, 106, 1)
dynamic GREEN_BUTTON_COLOR = colorSetter();
const LOGIN_FOOTER_TEXT_COLOR = Color.fromRGBO(74, 74, 75, 1);

//Location Page
const GRADIENT_COMPONENT_COLOR1 = Color.fromRGBO(102, 102, 102, 0.8);
const GRADIENT_COMPONENT_COLOR2 = Color.fromRGBO(85, 85, 85, 0.4);

const SEARCH_BAR_HINT_TEXT_COLOR = Color.fromRGBO(158, 158, 158, 1);
const NAVIGATION_ICON_COLOR = Color.fromRGBO(59, 59, 59, 1);
const CITY_HEADING_COLOR = Color.fromRGBO(242, 242, 242, 1);

//Home Page
const TAB_BAR_GRADIENT_COLOR1 =  Color.fromRGBO(68, 68, 68, 0.5);
const TAB_BAR_GRADIENT_COLOR2 = Color.fromRGBO(217, 217, 217, 0.25);

const SELECTED_TAB_TEXT_COLOR =Color.fromRGBO(136, 136, 136, 1);
const HOMEPAGE_BACKGROUND_COLOR = Color.fromRGBO(56, 56, 56,1);
const MOVIE_VIEW_GRADIENT_COLOR1 =Color.fromRGBO(68, 68, 68, 0);
const MOVIE_VIEW_GRADIENT_COLOR2 =Color.fromRGBO(0, 0, 0, 1);
const MOVIE_VIEW_DOT_COLOR =Color.fromRGBO(217, 217, 217, 1);
const MOVIE_VIEW_TEXT_COLOR =Color.fromRGBO(255, 255, 255, 1);
const MOVIE_VIEW_TEXT_COLOR_LOW_OPACITY =Color.fromRGBO(255, 255, 255, 0.5);
const MOVIE_VIEW_RELEASE_TAG_TEXT_COLOR =Color.fromRGBO(85, 85, 85, 1);

//Movie Detail Page
const MOVIE_DETAIL_GRADIENT_COLOR1 =Color.fromRGBO(34, 34, 34, 0.8);
const MOVIE_DETAIL_GRADIENT_COLOR2 =Color.fromRGBO(17, 17, 17, 0.6);
const MOVIE_DETAIL_SHADOW_COLOR = Color.fromRGBO(51, 51, 51,0.5);

const MOVIE_DETAIL_REMINDER_GRADIENT_COLOR1 = Color.fromRGBO(255, 255, 255, 0.6);
const MOVIE_DETAIL_REMINDER_GRADIENT_COLOR2  = Color.fromRGBO(204, 204, 204, 0.6);
const MOVIE_DETAIL_REMINDER_GRADIENT_COLOR3  = Color.fromRGBO(221, 221, 221, 0.3);

const MOVIE_DETAIL_REMINDER_TEXT_COLOR  = Color.fromRGBO(200, 200, 200, 1);

//Move Search Page
const MOVIE_SEARCH_HINT_COLOR  = Color.fromRGBO(68, 68, 68, 1);

//Chose Cinma and Time Page
const CINEMA_FORMAT_CHIP_COLOR  = Color.fromRGBO(85, 85, 85, 1);
const CINEMA_FILLING_FAST_COLOR  = Color.fromRGBO(255, 122, 0, 1);
const CINEMA_ALLMOST_FULL_COLOR  = Color.fromRGBO(255, 0, 184, 1);
const CINEMA_INDICATOR_BACKGROUND_COLOR  = Color.fromRGBO(34, 34, 34, 1);
const CINEMA_FEATURES_COLOR = Color.fromRGBO(170, 170, 170, 1);
const DIVIDER_COLOR = Color.fromRGBO(85, 85, 85, 1);

//Food and Beverage
const FNB_GRADIENT_COLOR1 = Color.fromRGBO(102, 102, 102, 0.8) ;
const FNB_GRADIENT_COLOR2 = Color.fromRGBO(51, 51, 51, 0.4);

//Checkout Page
const TICKET_POLICY_COLOR = Color.fromRGBO(255, 107, 0, 1);
const CHECKOUT_PAGE_GRADIENT_COLORR1 = Color.fromRGBO(68, 68, 68, 1);
const CHECKOUT_PAGE_GRADIENT_COLORR2 = Color.fromRGBO(34, 34, 34, 1);
const PAYMENT_CONTAINER_BORDER = Color.fromRGBO(255, 255, 255, 0.25);

//Booking Success Page
const BOOKING_SUCCESS_PAGE_BACKGROUND_COLOR = Color.fromRGBO(0, 0, 0, 0.9);

//Ticket Confirmation Page
const TICKET_CONFIRMATION_PAGE_GRADIENT_COLOR1 = Color.fromRGBO(98, 98, 98, 1);
const TICKET_CONFIRMATION_PAGE_GRADIENT_COLOR2 = Color.fromRGBO(38, 38, 38, 0);
const TICKET_CONFIRMATION_PAGE_GRADIENT_COLOR3 = Color.fromRGBO(39, 39, 39, 0.45);
const TICKET_CONFIRMATION_PAGE_GRADIENT_COLOR4 = Color.fromRGBO(51, 51, 51, 1);


dynamic colorSetter(){
    return THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR];
}