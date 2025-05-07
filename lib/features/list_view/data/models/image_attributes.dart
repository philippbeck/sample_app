// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:sample_app/features/list_view/data/models/generic_attributes.dart';

part 'image_attributes.g.dart';

@JsonSerializable()
class ImageAttributes extends GenericAttributes {
  ImageAttributes({
    required this.headline,
    required this.imageUrl,
    required this.url,
  });
  factory ImageAttributes.fromJson(Map<String, dynamic> json) =>
      _$ImageAttributesFromJson(json);

  final String headline;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String url;
  Map<String, dynamic> toJson() => _$ImageAttributesToJson(this);
}
