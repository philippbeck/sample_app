// ignore_for_file: public_member_api_docs
import 'package:json_annotation/json_annotation.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  Item({
    required this.id,
    required this.gender,
    required this.expiresAt,
    required this.headline,
    required this.imageUrl,
    required this.url,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  final int id;
  final Gender gender;
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;
  final String headline;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String url;

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
