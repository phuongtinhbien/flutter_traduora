// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationModel _$TranslationModelFromJson(Map<String, dynamic> json) {
  return TranslationModel(
    json['date'] == null
        ? null
        : DateModel.fromJson(json['date'] as Map<String, dynamic>),
    json['id'] as String,
    json['locale'] == null
        ? null
        : LocaleModel.fromJson(json['locale'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TranslationModelToJson(TranslationModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'id': instance.id,
      'locale': instance.locale,
    };
