import 'package:flutter_traduora/src/data/model/translation_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translation_response.g.dart';


@JsonSerializable()
class TranslationResponse {


  List<TranslationModel> data;


  TranslationResponse(this.data);

  factory TranslationResponse.fromJson(Map<String, dynamic> json) => _$TranslationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TranslationResponseToJson(this);
}