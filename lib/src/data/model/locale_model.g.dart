// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocaleModel _$LocaleModelFromJson(Map<String, dynamic> json) {
  return LocaleModel(
    json['code'] as String,
    json['language'] as String,
    json['region'] as String,
  );
}

Map<String, dynamic> _$LocaleModelToJson(LocaleModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'language': instance.language,
      'region': instance.region,
    };
