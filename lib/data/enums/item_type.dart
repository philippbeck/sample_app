// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

enum ContentType {
  teaser,
  slider,
  @JsonValue('brand_slider')
  brandSlider,
}
