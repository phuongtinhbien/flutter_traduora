import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()

part 'locale_model.g.dart';
@JsonSerializable()
class LocaleModel {
  @JsonKey(name:"code")
  String code;
  @JsonKey(name: "language")
  String language;
  @JsonKey(name: "region")
  String region;

  LocaleModel(this.code, this.language, this.region);

  factory LocaleModel.fromJson(Map<String, dynamic> json) => _$LocaleModelFromJson(json);
  Map<String, dynamic> toJson( instance) => _$LocaleModelToJson(this);
}