// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateModel _$DateModelFromJson(Map<String, dynamic> json) {
  return DateModel(
    json['created'] as String,
    json['modified'] as String,
  );
}

Map<String, dynamic> _$DateModelToJson(DateModel instance) => <String, dynamic>{
      'created': instance.created,
      'modified': instance.modified,
    };
