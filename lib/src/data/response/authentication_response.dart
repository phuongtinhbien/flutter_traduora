
import 'package:json_annotation/json_annotation.dart';
part 'authentication_response.g.dart';


@JsonSerializable()
class AuthenticationResponse {


  String accessToken;
  String expiresIn;
  String tokenType;


  AuthenticationResponse(this.accessToken, this.expiresIn, this.tokenType);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
  
}