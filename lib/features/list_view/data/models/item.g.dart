// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  id: (json['id'] as num).toInt(),
  gender: $enumDecode(_$GenderEnumMap, json['gender']),
  expiresAt: DateTime.parse(json['expires_at'] as String),
  headline: json['headline'] as String,
  imageUrl: json['image_url'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'id': instance.id,
  'gender': _$GenderEnumMap[instance.gender]!,
  'expires_at': instance.expiresAt.toIso8601String(),
  'headline': instance.headline,
  'image_url': instance.imageUrl,
  'url': instance.url,
};

const _$GenderEnumMap = {Gender.male: 'male', Gender.female: 'female'};
