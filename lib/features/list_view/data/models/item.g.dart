// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  id: (json['id'] as num).toInt(),
  type: $enumDecode(_$ContentTypeEnumMap, json['type']),
  gender: $enumDecode(_$GenderEnumMap, json['gender']),
  expiresAt: DateTime.parse(json['expires_at'] as String),
  categories:
      (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$ContentTypeEnumMap[instance.type]!,
  'gender': _$GenderEnumMap[instance.gender]!,
  'expires_at': instance.expiresAt.toIso8601String(),
  'categories': instance.categories,
};

const _$ContentTypeEnumMap = {
  ContentType.teaser: 'teaser',
  ContentType.slider: 'slider',
  ContentType.brandSlider: 'brand_slider',
};

const _$GenderEnumMap = {Gender.male: 'male', Gender.female: 'female'};
