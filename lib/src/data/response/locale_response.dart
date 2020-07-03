import 'package:flutter_traduora/src/data/model/locale_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locale_response.g.dart';

@JsonSerializable()
class LocaleResponse {
  
  List<LocaleModel> data;

  LocaleResponse(this.data);

  factory LocaleResponse.fromJson(Map<String, dynamic> json) => _$LocaleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LocaleResponseToJson(this);


}