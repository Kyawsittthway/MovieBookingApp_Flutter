
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/user_info_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'user_info_persistence_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_USER_INFO_PERSISTENCE_VO,adapterName: "UserInfoPersistenceVOAdapter")
class UserInfoPersistenceVO{

  @HiveField(0)
  String? token;

  @HiveField(1)
  UserInfoVO? userInfoVO;

  UserInfoPersistenceVO(this.token, this.userInfoVO);
}