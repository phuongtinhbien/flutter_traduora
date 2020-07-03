import 'package:flutter_traduora/src/data/model/date_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

@JsonSerializable()
class ProjectModel {
  String code;
  String name;
  String maxStrings;
  DateModel date;


  ProjectModel(this.code, this.name, this.maxStrings, this.date);

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson(instance) => _$ProjectModelToJson(this);
}
