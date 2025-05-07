// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';
import 'package:sample_app/features/list_view/data/enums/item_type.dart';
import 'package:sample_app/features/list_view/data/models/generic_attributes.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  Content({required this.id, required this.type, this.gender, this.expiresAt});

  factory Content.fromJson(Map<String, dynamic> json) {
    final details = _$ContentFromJson(json);
    details.attributes = attributesFromJson(json);
    return details;
  }

  final int id;
  final ContentType type;
  final Gender? gender;
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final GenericAttributes attributes;
  Map<String, dynamic> toJson() => _$ContentToJson(this);

  static GenericAttributes attributesFromJson(Map<String, dynamic> json) {
    return GenericAttributes.fromJson(
      json: json['attributes'] as Map<String, dynamic>,
      type: $enumDecode(_$ContentTypeEnumMap, json['type']),
    );
  }
}
