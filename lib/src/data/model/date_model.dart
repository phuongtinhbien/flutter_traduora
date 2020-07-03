
import 'package:json_annotation/json_annotation.dart';

part 'date_model.g.dart';


@JsonSerializable()
class DateModel {


  String created;
  String modified;


  DateModel(this.created, this.modified);

  factory DateModel.fromJson(Map<String, dynamic> json) => _$DateModelFromJson(json);
  Map<String, dynamic> toJson( instance) => _$DateModelToJson(this);
}