import 'dart:collection';
import 'dart:ui';

import 'package:flutter/widgets.dart';
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

  static initalize({traduoraUrl, grantType, projectId, clientId, secretKey})async {
    TRADUORA_URL = traduoraUrl;
    GRANT_TYPE = grantType;
    PROJECT_ID = projectId;
    CLIENT_ID = clientId;
    SECRET_KEY = secretKey;
    TraduoraStorageManager.initalize();
    bool authencated = await TraduoraManager.authenticateTraduora();
    if (authencated){
      TraduoraManager.fetchSupportedLocale();
      TraduoraManager.fetchAllMessages();
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
    TraduoraManager.currentTranslation[key] ?? "";
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Traduora> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(
          languageCode: 'vi', countryCode: 'VN', scriptCode: "Tiếng Việt"),
      Locale.fromSubtags(languageCode: 'en', scriptCode: "English"),
    ];
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
