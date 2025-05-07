// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemAttributes _$ItemAttributesFromJson(Map<String, dynamic> json) =>
    ItemAttributes(
      items:
          (json['items'] as List<dynamic>)
              .map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ItemAttributesToJson(ItemAttributes instance) =>
    <String, dynamic>{'items': instance.items};
