// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocaleResponse _$LocaleResponseFromJson(Map<String, dynamic> json) {
  return LocaleResponse(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : LocaleModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocaleResponseToJson(LocaleResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
