// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateRequest _$AuthenticateRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      disallowNullValues: const ['grant_type', 'client_id', 'client_secret']);
  return AuthenticateRequest()
    ..grantType = json['grant_type'] as String
    ..clientId = json['client_id'] as String
    ..clientSecret = json['client_secret'] as String;
}

Map<String, dynamic> _$AuthenticateRequestToJson(AuthenticateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('grant_type', instance.grantType);
  writeNotNull('client_id', instance.clientId);
  writeNotNull('client_secret', instance.clientSecret);
  return val;
}
