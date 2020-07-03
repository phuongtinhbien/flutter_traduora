// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return ProjectModel(
    json['code'] as String,
    json['name'] as String,
    json['maxStrings'] as String,
    json['date'] == null
        ? null
        : DateModel.fromJson(json['date'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'maxStrings': instance.maxStrings,
      'date': instance.date,
    };
