// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  id: (json['id'] as num).toInt(),
  type: $enumDecode(_$ContentTypeEnumMap, json['type']),
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  expiresAt:
      json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$ContentTypeEnumMap[instance.type]!,
  'gender': _$GenderEnumMap[instance.gender],
  'expires_at': instance.expiresAt?.toIso8601String(),
};

const _$ContentTypeEnumMap = {
  ContentType.teaser: 'teaser',
  ContentType.slider: 'slider',
  ContentType.brandSlider: 'brand_slider',
};

const _$GenderEnumMap = {Gender.male: 'male', Gender.female: 'female'};
