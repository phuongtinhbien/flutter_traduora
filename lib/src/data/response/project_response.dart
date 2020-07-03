import 'package:flutter_traduora/src/data/model/project_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_response.g.dart';

@JsonSerializable()
class ProjectResponse {


  ProjectModel data;


  ProjectResponse(this.data);

  factory ProjectResponse.fromJson(Map<String, dynamic> json) => _$ProjectResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectResponseToJson(this);
}