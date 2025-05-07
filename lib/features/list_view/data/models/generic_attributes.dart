// ignore_for_file: public_member_api_docs

import 'package:sample_app/features/list_view/data/enums/item_type.dart';
import 'package:sample_app/features/list_view/data/models/image_attributes.dart';
import 'package:sample_app/features/list_view/data/models/item_attributes.dart';
import 'package:sample_app/features/list_view/data/models/url_attributes.dart';

abstract class GenericAttributes {
  const GenericAttributes();
  factory GenericAttributes.fromJson({
    required Map<String, dynamic> json,
    required ContentType type,
  }) {
    switch (type) {
      case ContentType.teaser:
        return ImageAttributes.fromJson(json);
      case ContentType.slider:
        return ItemAttributes.fromJson(json);
      case ContentType.brandSlider:
        return UrlAttributes.fromJson(json);
    }
  }
}
