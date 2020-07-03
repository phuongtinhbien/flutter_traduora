import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_traduora/src/data/request/authenticate_request.dart';
import 'package:flutter_traduora/src/data/response/authentication_response.dart';
import 'package:flutter_traduora/src/data/response/locale_response.dart';
import 'package:flutter_traduora/src/data/response/project_response.dart';
import 'package:flutter_traduora/src/data/response/translation_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(
  baseUrl: "https://traduora.cooky.com.vn/api/v1/",
  autoCastResponse: true,
)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("auth/token")
  Future<AuthenticationResponse> requestAuthenticationToken(
      @Body() AuthenticateRequest request);

  @GET("projects/{projectId}")
  Future<ProjectResponse> getProject(@Path("projectId") String projectId);

  @GET("projects/{projectId}/exports")
  Future exportProject(
      @Path("projectId") String projectId,
      @Query("locale") String locale,
      @Query("format") String format);


  @GET("projects/{projectId}/translations")
  Future<TranslationResponse> getTranslations(
      @Path("projectId") String projectId);

  @GET("projects/{projectId}/translations")
  Future<LocaleResponse> getSupportedLocales(@Path("projectId") String projectId);
}
