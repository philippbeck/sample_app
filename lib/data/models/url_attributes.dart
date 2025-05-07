// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:sample_app/data/models/generic_attributes.dart';

part 'url_attributes.g.dart';

@JsonSerializable()
class UrlAttributes extends GenericAttributes {
  UrlAttributes({required this.itemsUrl});
  factory UrlAttributes.fromJson(Map<String, dynamic> json) =>
      _$UrlAttributesFromJson(json);

  @JsonKey(name: 'items_url')
  final String itemsUrl;
  Map<String, dynamic> toJson() => _$UrlAttributesToJson(this);
}
