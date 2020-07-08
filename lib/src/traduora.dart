import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_traduora/src/data/model/locale_model.dart';
import 'package:flutter_traduora/src/manager/traduora_manager.dart';
import 'package:flutter_traduora/src/manager/traduora_storage_manager.dart';
import 'package:flutter_traduora/src/traduora_helper.dart';

String TRADUORA_URL;
String GRANT_TYPE;
String PROJECT_ID;
String CLIENT_ID;
String SECRET_KEY;

class Traduora {
  static Traduora current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static initalize({traduoraUrl,
    grantType,
    projectId,
    clientId,
    secretKey,
    List<Locale> supportedLocale,
    String defaultLocale,
    List<String> pathString}) async {
    TRADUORA_URL = traduoraUrl;
    GRANT_TYPE = grantType;
    PROJECT_ID = projectId;
    CLIENT_ID = clientId;
    SECRET_KEY = secretKey;
    TraduoraManager.supportedLocales = supportedLocale;
    TraduoraManager.defaultLocale = defaultLocale;
    TraduoraManager.localPathStrings = pathString;
    await TraduoraStorageManager.initalize();
    await Traduora.loadTraduora();
  }

  static loadTraduora() async {
    try {
      if (TraduoraStorageManager
          .getToken()
          .isEmpty ||
          DateTime
              .now()
              .millisecond >
              TraduoraStorageManager.getExpiredDate()) {
        bool authencated = await TraduoraManager.authenticateTraduora();
        if (authencated) {
          await TraduoraManager.fetchMessages(TraduoraManager.defaultLocale);
//        await TraduoraManager.fetchSupportedLocale();
          TraduoraManager.fetchAllMessages();
          return true;
        } else {
          TraduoraManager.loadLocalTraduora(TraduoraManager.defaultLocale,
              TraduoraHelper.findPathString(TraduoraManager.defaultLocale));
        }
      } else {
        TraduoraManager.fetchAllMessages();
      }
    } catch (ignore) {
      print("loadTraduora: " + ignore.toString());
    }
  }

  static Traduora of(BuildContext context) {
    return Localizations.of<Traduora>(context, Traduora);
  }

  static Future<Traduora> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = TraduoraHelper.canonicalizedLocale(name);
    return TraduoraManager.initializeMessages(localeName).then((_) {
      TraduoraManager.defaultLocale = localeName;
      Traduora.current = Traduora();
      return Traduora.current;
    });
  }

  String getString(String key) {
    return TraduoraManager.currentTranslation[key] ?? "";
  }

  String getCurrentTranslation() {
    return TraduoraManager.currentTranslation.toString();
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Traduora> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return TraduoraManager.supportedLocales;
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<Traduora> load(Locale locale) => Traduora.load(locale);

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
