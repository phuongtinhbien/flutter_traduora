import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_traduora/src/manager/traduora_storage_manager.dart';
import 'package:flutter_traduora/src/network/rest_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../flutter_traduora.dart';

const int TIME_OUT = 30000;

class ApiProvider {
  BaseOptions _options;
  Dio _dio;
  RestClient _client;

  static ApiProvider apiProvider;

  ApiProvider() {
    _dio = Dio();
    _options = new BaseOptions();
  }

  static getInstance() {
    if (apiProvider == null) {
      apiProvider = new ApiProvider();
    }
    return apiProvider;
  }

  RestClient getRestClient() {
    if (_client == null) {
      _client = initRestClient();
    }
    return _client;
  }

  RestClient initRestClient() {
    if (Platform.isAndroid) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // Hook into the findProxy callback to set the client's proxy.
        // This is a workaround to allow Charles to receive
        // SSL payloads when your app is running on Android.
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => Platform.isAndroid;
      };
      if (kDebugMode) {
        _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ));
      }
    }

    _options.connectTimeout = TIME_OUT;
    _options.receiveTimeout = TIME_OUT;
    _options.sendTimeout = TIME_OUT;
    _options.headers["accept"] = "application/json";
    _options.headers["Content-Type"] = "application/json";
    _dio.options = _options;

    try {
      //Token
      String token = TraduoraStorageManager.preferences.getString(TOKEN) ?? "";
      if (token.isNotEmpty) {
        _options.headers["Authorization"] = "Bearer ${token}";
      }
    } catch (err) {
      if (kDebugMode) {
        print("sharedPreferences: " + err.toString());
      }
    }
    return RestClient(_dio, baseUrl: TRADUORA_URL);
  }

  void notifyChange() {
    _client = initRestClient();
  }
}
