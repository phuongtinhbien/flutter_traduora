// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateRequest _$AuthenticateRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      disallowNullValues: const ['grantType', 'clientId', 'clientSecret']);
  return AuthenticateRequest()
    ..grantType = json['grantType'] as String
    ..clientId = json['clientId'] as String
    ..clientSecret = json['clientSecret'] as String;
}

Map<String, dynamic> _$AuthenticateRequestToJson(AuthenticateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('grantType', instance.grantType);
  writeNotNull('clientId', instance.clientId);
  writeNotNull('clientSecret', instance.clientSecret);
  return val;
}
