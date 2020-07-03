// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectResponse _$ProjectResponseFromJson(Map<String, dynamic> json) {
  return ProjectResponse(
    json['data'] == null
        ? null
        : ProjectModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProjectResponseToJson(ProjectResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
