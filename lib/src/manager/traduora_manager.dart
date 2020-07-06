import 'dart:collection';
import 'dart:convert';

import 'package:flutter_traduora/flutter_traduora.dart';
import 'package:flutter_traduora/src/data/model/locale_model.dart';
import 'package:flutter_traduora/src/data/model/supported_locale.dart';
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
  static var currentTranslation;
  static ApiProvider apiProvider = new ApiProvider();

  static List<LocaleModel> supportedLocale = [];

  static Future<bool> initializeMessages(String localeName) async {
    var availableLocale = TraduoraHelper.verifiedLocale(
        localeName,
        (locale) =>
            supportedLocale.any((element) => element.code.contains(locale)) !=
            null,
        onFailure: (_) => null);
    if (availableLocale == null) {
      return false;
    }

    var lib = TraduoraStorageManager.getTranslation(availableLocale);
    if (lib == null) {
      await fetchMessages(availableLocale);
    } else {
      currentTranslation = lib;
      fetchAllMessages();
    }
    //TODO change value curent at hashmap
    return true;
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
        if (TraduoraStorageManager.getToken().isNotEmpty) {
          apiProvider = new ApiProvider();
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
          await apiProvider.getRestClient().getSupportedLocales(PROJECT_ID);
      if (response != null &&
          response.data != null &&
          response.data.isNotEmpty) {
        for (SupportedLocale i in response.data) {
          supportedLocale.add(i.locale);
        }
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
      String response = await apiProvider
          .getRestClient()
          .exportProject(PROJECT_ID, localeCode, FORMAT_EXPORT);
      print(response);
      final res = jsonDecode(response);
      TraduoraStorageManager.storeExportTranslation(localeCode, res);
      if (defaultLocale == localeCode) {
        currentTranslation = res;
      }
      return true;
    } catch (ignore) {
      return false;
    }
  }
}
