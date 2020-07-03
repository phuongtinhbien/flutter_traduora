import 'dart:collection';

import 'package:flutter_traduora/flutter_traduora.dart';
import 'package:flutter_traduora/src/data/model/locale_model.dart';
import 'package:flutter_traduora/src/data/request/authenticate_request.dart';
import 'package:flutter_traduora/src/data/response/authentication_response.dart';
import 'package:flutter_traduora/src/data/response/locale_response.dart';
import 'package:flutter_traduora/src/manager/traduora_storage_manager.dart';
import 'package:flutter_traduora/src/network/api_provider.dart';
import 'package:flutter_traduora/src/traduora_helper.dart';

const String FORMAT_EXPORT = "jsonflat";

class TraduoraManager {
  static String defaultLocale;
  static String systemLocale = 'en_US';
  static Map<String, String> currentTranslation = new Map();
  static ApiProvider apiProvider = new ApiProvider();


  static List<LocaleModel> supportedLocale = [];

  static Future<bool> initializeMessages(String localeName) async {
    var availableLocale = TraduoraHelper.verifiedLocale(
        localeName, (locale) => supportedLocale.any((element) => element.code.contains(locale)) != null,
        onFailure: (_) => null);
    if (availableLocale == null) {
      return new Future.value(false);
    }
    print("availableLocale: "+availableLocale);
    var lib = TraduoraStorageManager.getTranslation(availableLocale);
    if (lib == null){
      fetchMessages(availableLocale);
    } else {
      currentTranslation = lib;
    }
    //TODO change value curent at hashmap
    return new Future.value(true);
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
        TraduoraStorageManager.storeToken(response.accessToken);
        TraduoraStorageManager.storeExpiredDate(DateTime.now().millisecond +
            int.parse(response.expiresIn.replaceAll("s", "")));
        if (!TraduoraStorageManager.getToken().isNotEmpty) {
          apiProvider.notifyChange();
          return true;
        }
      }
      return false;
    } catch (ignore) {
      return false;
    }
  }

  static Future<bool> fetchSupportedLocale() async {
    try {
      LocaleResponse response =
          await apiProvider.getRestClient().getSupportedLocales();
      if (response != null &&
          response.data != null &&
          response.data.isNotEmpty) {
        supportedLocale.addAll(response.data);
        if (defaultLocale == null || defaultLocale.isEmpty) {
          defaultLocale = supportedLocale[0].code;
        }
        return true;
      }
      return false;
    } catch (ignore) {
      return false;
    }
  }

  static Future<bool> fetchAllMessages() async {
    if (supportedLocale.isNotEmpty) {
      try {
        for (int i = 0; i < supportedLocale.length; i++) {
          fetchMessages(supportedLocale[i].code);
        }
        return true;
      } catch (ignore) {
        return false;
      }
    }
  }

  static Future<bool> fetchMessages(String localeCode) async {
    try {
      Map<String, String> response = await apiProvider
          .getRestClient()
          .exportProject(PROJECT_ID, localeCode, FORMAT_EXPORT);
      TraduoraStorageManager.storeExportTranslation(localeCode, response);

      if (defaultLocale == localeCode) {
        currentTranslation = response;
      }
    } catch (ignore) {
      return false;
    }
  }
}
