// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:sample_app/features/list_view/data/models/generic_attributes.dart';
import 'package:sample_app/features/list_view/data/models/item.dart';

part 'item_attributes.g.dart';

@JsonSerializable()
class ItemAttributes extends GenericAttributes {
  ItemAttributes({required this.items});
  factory ItemAttributes.fromJson(Map<String, dynamic> json) =>
      _$ItemAttributesFromJson(json);

  final List<Item> items;
  Map<String, dynamic> toJson() => _$ItemAttributesToJson(this);
}
