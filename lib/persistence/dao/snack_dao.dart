import 'package:hive/hive.dart';


import '../../data.vos/vos/movie_vo.dart';
import '../../data.vos/vos/snack_vo.dart';
import '../hive_constants.dart';


class SnackDao{

  static final SnackDao _singleton = SnackDao._internal();

  factory SnackDao(){
    return _singleton;
  }
  SnackDao._internal();

  void saveSnackByCategoryId(List<SnackVO> snacks,int categoryId)async{
    await getSnackBox().put(categoryId, snacks);
  }


  List<SnackVO>? getSnackByCategoryId(int id){
    return getSnackBox().get(id,defaultValue: [])?.cast<SnackVO>();
  }

  List<List> getAllSnack(){
    return getSnackBox().values.toList();
  }
  /// Reactive Programming
  Stream<void> getSnackBoxEvents(){
    return getSnackBox().watch();
  }

  Stream<List<SnackVO>?> getSnackByCategoryIdStream(int id){
    return Stream.value(getSnackByCategoryId(id));
  }

  Box<List> getSnackBox(){
    return Hive.box<List>(BOX_NAME_SNACK_VO);
  }
}