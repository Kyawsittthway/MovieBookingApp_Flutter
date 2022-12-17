import 'package:flutter/material.dart';

///Theme Color
const Map<String,dynamic> THEME_COLORS = {
  "COLOR_ORIGINAL" : Color.fromRGBO(0, 255, 106, 1),
  "COLOR_NEW" : Color.fromRGBO(233,189,68,1.0)
};

enum ActorListStyle{
  ScrollActorList,
  WrapActorList
}
const Map<String,dynamic>ACTOR_LIST_STYLES = {
  "SCROLL_ACTOR_LIST" : ActorListStyle.ScrollActorList,
  "WRAP_ACTOR_LIST" : ActorListStyle.WrapActorList
};