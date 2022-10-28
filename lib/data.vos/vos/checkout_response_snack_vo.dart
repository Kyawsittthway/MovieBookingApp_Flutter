
import 'package:json_annotation/json_annotation.dart';

part 'checkout_response_snack_vo.g.dart';


@JsonSerializable()
class CheckoutResponseSnackVO{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name:'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'image')
  String? imagePath;

  @JsonKey(name: 'price')
  int? price;

  @JsonKey(name: 'unit_price')
  int? unit_price;

  @JsonKey(name:'quantity')
  int? quantity;

  @JsonKey(name:'total_price')
  int? totalPrice;

  CheckoutResponseSnackVO(this.id, this.name, this.description, this.imagePath,
      this.price, this.unit_price, this.quantity, this.totalPrice);

  factory CheckoutResponseSnackVO.fromJson(Map<String,dynamic>json)=>_$CheckoutResponseSnackVOFromJson(json);

  Map<String,dynamic>toJson()=>_$CheckoutResponseSnackVOToJson(this);
}

// "id": 4191,
// "name": "Burger Combo1",
// "description": "Et dolores eaque officia aut.",
// "image": "https://storage.googleapis.com/mmds-padc/PADC/tmba/snacks/burger.jpeg",
// "price": 2,
// "unit_price": 2,
// "quantity": 2,
// "total_price": 4