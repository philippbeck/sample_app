// ignore_for_file: public_member_api_docs
import 'package:json_annotation/json_annotation.dart';
import 'package:sample_app/data/enums/gender.dart';
import 'package:sample_app/data/enums/item_type.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  Item({
    required this.id,
    required this.type,
    required this.gender,
    required this.expiresAt,
    required this.categories,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  final int id;
  final ContentType type;
  final Gender gender;
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;
  final List<String> categories;

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
