import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/config_vo.dart';


import '../../data.vos/vos/movie_vo.dart';
import '../hive_constants.dart';

class ConfigDao{

  static final ConfigDao _singleton = ConfigDao._internal();

  factory ConfigDao(){
    return _singleton;
  }
  ConfigDao._internal();


  void saveConfig(ConfigVO config)async{
    return getConfigVOBox().put(config.value,config);
  }

  List<ConfigVO>getAllConfigs(){
    return getConfigVOBox().values.toList();
  }

  ConfigVO? getConfigByTime(String timeValue){
    return getConfigVOBox().get(timeValue);
  }

  Box<ConfigVO> getConfigVOBox(){
    return Hive.box<ConfigVO>(BOX_NAME_CONFIG_VO);
  }
}