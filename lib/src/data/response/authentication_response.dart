
import 'package:json_annotation/json_annotation.dart';
part 'authentication_response.g.dart';


@JsonSerializable()
class AuthenticationResponse {
  @JsonKey(name:"access_token")
  String accessToken;
  @JsonKey(name:"expires_in")
  String expiresIn;
  @JsonKey(name:"token_type")
  String tokenType;


  AuthenticationResponse(this.accessToken, this.expiresIn, this.tokenType);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
  
}