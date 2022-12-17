class EnvironmentConfig{
  static const String CONFIG_THEME_COLOR = String.fromEnvironment("CONFIG_THEME_COLOR",defaultValue: "COLOR_ORIGINAL");
  static const String CONFIG_ACTOR_LIST_STYLE = String.fromEnvironment("CONFIG_ACTOR_LIST_STYLE",defaultValue: "SCROLL_ACTOR_LIST");
}


///FLAVORS

///Food Panda
/// flutter run --dart-define=CONFIG_THEME_COLOR=COLOR_ORIGINAL --dart-define=CONFIG_ACTOR_LIST_STYLE=SCROLL_ACTOR_LIST


///Grab Food
/// flutter run --dart-define=CONFIG_THEME_COLOR=COLOR_NEW --dart-define=CONFIG_ACTOR_LIST_STYLE=WRAP_ACTOR_LIST