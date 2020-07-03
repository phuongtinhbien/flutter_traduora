
import 'package:json_annotation/json_annotation.dart';
part 'authenticate_request.g.dart';


@JsonSerializable()
class AuthenticateRequest {
  @JsonKey(name: "grantType", disallowNullValue: true)
  String grantType;
  @JsonKey(name: "clientId", disallowNullValue: true)
  String clientId;
  @JsonKey(name: "clientSecret", disallowNullValue: true)
  String clientSecret;


  AuthenticateRequest();

  factory AuthenticateRequest.fromJson(Map<String, dynamic> json) => _$AuthenticateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateRequestToJson(this);
}