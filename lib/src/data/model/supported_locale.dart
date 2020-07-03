import 'package:flutter_traduora/src/data/model/date_model.dart';
import 'package:flutter_traduora/src/data/model/locale_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supported_locale.g.dart';

@JsonSerializable()
class SupportedLocale {
  String id;
  DateModel date;
  LocaleModel locale;


  SupportedLocale(this.id, this.date, this.locale);

  factory SupportedLocale.fromJson(Map<String, dynamic> json) => _$SupportedLocaleFromJson(json);
  Map<String, dynamic> toJson( instance) => _$SupportedLocaleToJson(this);

}