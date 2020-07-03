import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()

part 'locale_model.g.dart';
@JsonSerializable()
class LocaleModel {


  String code;
  String language;
  String region;

  LocaleModel(this.code, this.language, this.region);

  factory LocaleModel.fromJson(Map<String, dynamic> json) => _$LocaleModelFromJson(json);
  Map<String, dynamic> toJson( instance) => _$LocaleModelToJson(this);
}