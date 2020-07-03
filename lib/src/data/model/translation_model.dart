import 'package:flutter_traduora/src/data/model/date_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'locale_model.dart';

part 'translation_model.g.dart';

@JsonSerializable()
class TranslationModel {

  DateModel date;
  String id;
  LocaleModel locale;

  TranslationModel(this.date, this.id, this.locale);

  factory TranslationModel.fromJson(Map<String, dynamic> json) => _$TranslationModelFromJson(json);
  Map<String, dynamic> toJson( instance) => _$TranslationModelToJson(this);
}