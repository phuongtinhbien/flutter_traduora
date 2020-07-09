import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
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
  static List<String> localPathStrings= [];
  static String systemLocale = 'en_US';
  static var currentTranslation;
  static ApiProvider apiProvider = new ApiProvider();

  static List<Locale> supportedLocales = [];

  static Future<bool> initializeMessages(String localeName) async {
    try {
      print("initializeMessages");
      var availableLocale = TraduoraHelper.verifiedLocale(localeName, (locale) {
        return supportedLocales
            .any((element) => localeName.contains(element.languageCode));
      }, onFailure: (_) => null);
      if (availableLocale == null) {
        return false;
      }
      print("availableLocale:" + availableLocale);
      await loadLocalTraduora(availableLocale);
      loadRemoteTraduora(availableLocale);


    } catch (ignore) {
      print("traduora: " + ignore.toString());
    }

    print("initializeMessages");
  }

  static loadRemoteTraduora(String localName) async {
    if (TraduoraStorageManager.getToken().isEmpty ||
        DateTime.now().millisecondsSinceEpoch >
            TraduoraStorageManager.getExpiredDate()) {
      bool authencated = await TraduoraManager.authenticateTraduora();
      if (authencated) {
        await fetchMessages(localName);
//        fetchAllMessages();
        return true;
      }
    } else {
//      fetchAllMessages();
    }
  }

  static loadLocalTraduora (String localName) async {
    var lib = TraduoraStorageManager.getTranslation(localName);
    if (lib != null && lib.isNotEmpty) {
      currentTranslation = lib;
      return true;
    } else {
      if (localPathStrings.isNotEmpty){
        currentTranslation = await loadLocalFileTraduora(localName, TraduoraHelper.findPathString(localName));
        return true;
      }
      return false;
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
                int.parse(response.expiresIn.replaceAll("s", ""))*1000);
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
    if (supportedLocales.isNotEmpty) {
      try {
        for (int i = 0; i < supportedLocales.length; i++) {
          var availableLocale = supportedLocales[i].languageCode;
          if (supportedLocales[i].countryCode != null && supportedLocales[i].countryCode.isNotEmpty){
            availableLocale = availableLocale+"_"+supportedLocales[i].countryCode;
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

  static dynamic loadLocalFileTraduora(String availableLocale, String pathString) async {
    if (availableLocale == null || availableLocale.isEmpty){
      //TODO add throw Exception
      throw ArgumentError('Invalid locale "$availableLocale"');
    }
    if (pathString == null || pathString.isEmpty) {
      //TODO add throw Exception
      throw ArgumentError('Invalid pathString "$pathString". File name should be intl_{name}');
    }
    String data = await rootBundle.loadString(pathString);
    return json.decode(data);
  }
}
