import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_traduora/flutter_traduora.dart';
import 'package:flutter_traduora/src/data/request/authenticate_request.dart';
import 'package:flutter_traduora/src/data/response/authentication_response.dart';
import 'package:flutter_traduora/src/manager/traduora_storage_manager.dart';
import 'package:flutter_traduora/src/network/api_provider.dart';
import 'package:flutter_traduora/src/traduora_helper.dart';

const String FORMAT_EXPORT = "jsonflat";

class TraduoraManager {
  static String defaultLocale;
  static String systemLocale = 'en_US';
  static var currentTranslation;
  static ApiProvider apiProvider = new ApiProvider();

  static List<Locale> supportedLocale = [
    Locale.fromSubtags(
      languageCode: 'vi',
      countryCode: 'VN',
    ),
    Locale.fromSubtags(
      languageCode: 'en',
    ),
  ];

  static Future<bool> initializeMessages(String localeName) async {
    try {
      print("initializeMessages");
      var availableLocale = TraduoraHelper.verifiedLocale(localeName, (locale) {
        return supportedLocale
            .any((element) => localeName.contains(element.languageCode));
      }, onFailure: (_) => null);
      if (availableLocale == null) {
        return false;
      }
      print("availableLocale:" + availableLocale);
      var lib = TraduoraStorageManager.getTranslation(availableLocale);
      print("lib: "+ lib.toString());
      if (lib != null && lib.isNotEmpty) {
        currentTranslation = lib;
        return true;
      } else {
        return false;
      }
    } catch (ignore) {
      print("traduora: " + ignore.toString());
    }

    print("initializeMessages");
  }

  static loadTraduora(String localName) async {
    if (TraduoraStorageManager.getToken().isEmpty ||
        DateTime.now().millisecondsSinceEpoch >
            TraduoraStorageManager.getExpiredDate()) {
      bool authencated = await TraduoraManager.authenticateTraduora();
      if (authencated) {
        await fetchMessages(localName);
        fetchAllMessages();
        return true;
      }
    } else {
      fetchAllMessages();
    }
  }

  static Future<bool> authenticateTraduora() async {
    AuthenticateRequest request = new AuthenticateRequest();
    request.clientId = CLIENT_ID;
    request.grantType = GRANT_TYPE;
    request.clientSecret = SECRET_KEY;
    try {
      AuthenticationResponse response =
          await apiProvider.getRestClient().requestAuthenticationToken(request);
      if (response != null) {
        await TraduoraStorageManager.storeToken(response.accessToken);
        await TraduoraStorageManager.storeExpiredDate(
            DateTime.now().millisecond +
                int.parse(response.expiresIn.replaceAll("s", "")));
        if (TraduoraStorageManager.getToken().isNotEmpty) {
          apiProvider = new ApiProvider();
          return true;
        }
      }
      return false;
    } catch (ignore) {
      print("authenticateTraduora:" + ignore.toString());
      return false;
    }
  }

  static Future<bool> fetchAllMessages() async {
    if (supportedLocale.isNotEmpty) {
      try {
        for (int i = 0; i < supportedLocale.length; i++) {
          var availableLocale = supportedLocale[i].languageCode;
          if (supportedLocale[i].countryCode != null && supportedLocale[i].countryCode.isNotEmpty){
            availableLocale = availableLocale+"_"+supportedLocale[i].countryCode;
          }
          fetchMessages(availableLocale);
        }
        return true;
      } catch (ignore) {
        DioError dioError = ignore as DioError;
        print("fetchAllMessages:" + dioError.request.toString());
        print("fetchAllMessages:" + ignore.toString());
        return false;
      }
    }
  }

  static Future<bool> fetchMessages(String localeCode) async {
    try {
      String response = await apiProvider
          .getRestClient()
          .exportProject(PROJECT_ID, localeCode, FORMAT_EXPORT);
      final res = jsonDecode(response);
      if (defaultLocale == localeCode) {
        currentTranslation = res;
      }
      await TraduoraStorageManager.storeExportTranslation(localeCode, response);
      return true;
    } catch (ignore) {
      DioError dioError = ignore as DioError;
      print("fetchMessages:" + dioError.request.headers.toString());
      print("fetchMessages:" + ignore.toString());

      return false;
    }
  }
}
