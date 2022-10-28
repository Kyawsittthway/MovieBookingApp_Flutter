
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

import '../../data.vos/vos/snack_category_vo.dart';


part 'get_snack_categories_response.g.dart';

@JsonSerializable()
class GetSnackCategoriesResponse extends BaseResponseVO{

  @JsonKey(name: 'data')
  List<SnackCategoryVO>? snackCategories;

  GetSnackCategoriesResponse(int? code, String? message,this.snackCategories) : super(code, message);

  factory GetSnackCategoriesResponse.fromJson(Map<String,dynamic>json)=>_$GetSnackCategoriesResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetSnackCategoriesResponseToJson(this);

}