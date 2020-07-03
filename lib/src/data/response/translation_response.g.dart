// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationResponse _$TranslationResponseFromJson(Map<String, dynamic> json) {
  return TranslationResponse(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TranslationModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TranslationResponseToJson(
        TranslationResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
