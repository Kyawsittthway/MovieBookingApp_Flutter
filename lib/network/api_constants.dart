/// BASE URL
const String BASE_URL = "https://tmba.padc.com.mm";
const String BASE_URL_DIO = "https://api.themoviedb.org";
const String IMAGE_BASE_URL = "http://image.tmdb.org/t/p/w400/";

/// ENDPOINTS-PADC
const String ENDPOINT_GET_OTP = "/api/v2/get-otp";
const String ENDPOINT_CHECK_OTP = "/api/v2/check-otp";
const String ENDPOINT_GET_BANNERS =  "/api/v2/banners";
const String ENDPOINT_GET_CONFIGS = "/api/v2/configurations";
const String ENDPOINT_GET_CINEMA_AND_SHOWTIME_BY_DATE = "/api/v2/cinema-day-timeslots"; // need authorization in api call to get data
const String ENDPOINT_GET_CINEMA = "/api/v2/cinemas";
const String ENDPOINT_SET_CITY = "/api/v2/set-city";
const String ENDPOINT_CHECKOUT = "/api/v2/checkout";
const String ENDPOINT_GET_SNACKS = "/api/v2/snacks";
const String ENDPOINT_GET_SNACK_CATEGORY = "/api/v2/snack-categories";
const String ENDPOINT_GET_PAYMENTTYPE = "/api/v2/payment-types";
const String ENDPOINT_SIGN_IN_WITH_GOOGLE = "/api/v2/sign-in-with-google";
const String ENDPOINT_GET_CITY = "/api/v2/cities";
const String ENDPOINT_GET_SEATING_PLAN = "/api/v2/seat-plan";


///ENDPOINTS- TMDB
const String ENDPOINT_GET_NOW_PLAYING = "/3/movie/now_playing";
const String ENDPOINT_GET_UPCOMING = "/3/movie/upcoming";
const String ENDPOINT_GET_GENRES= "/3/genre/movie/list";
const String ENDPOINT_GET_MOVIES_BY_GENRE = "/3/discover/movie";
const String ENDPOINT_GET_ACTORS = "/3/person/popular";
const String ENDPOINT_GET_MOVIE_DETAILS = "/3/movie";
const String ENDPOINT_GET_CREDITS_BY_MOVIE = "/3/movie";

///Parameters
const String PARAM_API_KEY = "api_key";
const String PARAM_LANGUAGE = "language";
const String PARAM_PAGE= "page";
const String PARAM_GENRE_ID = "with_genres";
///Constant Value
const String API_KEY = "f853ab5cc2a54f96587bcb876bdfebf1";
const String LANGUAGE_EN_US = "en-US";