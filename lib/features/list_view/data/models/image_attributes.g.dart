// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageAttributes _$ImageAttributesFromJson(Map<String, dynamic> json) =>
    ImageAttributes(
      headline: json['headline'] as String,
      imageUrl: json['image_url'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ImageAttributesToJson(ImageAttributes instance) =>
    <String, dynamic>{
      'headline': instance.headline,
      'image_url': instance.imageUrl,
      'url': instance.url,
    };
