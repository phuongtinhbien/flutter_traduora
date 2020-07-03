
import 'package:json_annotation/json_annotation.dart';
part 'authenticate_request.g.dart';


@JsonSerializable()
class AuthenticateRequest {
  @JsonKey(name: "grant_type", disallowNullValue: true)
  String grantType;
  @JsonKey(name: "client_id", disallowNullValue: true)
  String clientId;
  @JsonKey(name: "client_secret", disallowNullValue: true)
  String clientSecret;


  AuthenticateRequest();

  factory AuthenticateRequest.fromJson(Map<String, dynamic> json) => _$AuthenticateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateRequestToJson(this);
}