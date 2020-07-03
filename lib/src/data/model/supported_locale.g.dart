// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_locale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportedLocale _$SupportedLocaleFromJson(Map<String, dynamic> json) {
  return SupportedLocale(
    json['id'] as String,
    json['date'] == null
        ? null
        : DateModel.fromJson(json['date'] as Map<String, dynamic>),
    json['locale'] == null
        ? null
        : LocaleModel.fromJson(json['locale'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SupportedLocaleToJson(SupportedLocale instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'locale': instance.locale,
    };
