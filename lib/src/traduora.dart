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

  static initalize(
      {traduoraUrl, grantType, projectId, clientId, secretKey}) async {
    TRADUORA_URL = traduoraUrl;
    GRANT_TYPE = grantType;
    PROJECT_ID = projectId;
    CLIENT_ID = clientId;
    SECRET_KEY = secretKey;
    await TraduoraStorageManager.initalize();
    if (TraduoraStorageManager.getToken().isEmpty ||
        DateTime.now().millisecondsSinceEpoch >
            TraduoraStorageManager.getExpiredDate()) {
      await generateFirstLoading();
    } else {
      TraduoraManager.fetchAllMessages();
    }
  }

  static Future<bool> generateFirstLoading() async {
    bool authencated = await TraduoraManager.authenticateTraduora();
    if (authencated) {
      await TraduoraManager.fetchSupportedLocale();
      await TraduoraManager.fetchAllMessages();
      return true;
    }
  }

  static Traduora of(BuildContext context) {
    return Localizations.of<Traduora>(context, Traduora);
  }

  static Future<Traduora> load(Locale locale) async {
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<Traduora> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
//    if (TraduoraManager.supportedLocale != null ||
//        TraduoraManager.supportedLocale.isNotEmpty) {
//      List<Locale> supportedLocales = [];
//      for (LocaleModel item in TraduoraManager.supportedLocale) {
//        List<String> stringSplit;
//        if (item.code.contains("_")) {
//          stringSplit = item.code.split("_");
//          for (String item in stringSplit) {
//            item.replaceAll("_", "");
//          }
//        }
//        if (stringSplit != null || stringSplit.isNotEmpty) {
//          supportedLocales.add(Locale.fromSubtags(
//              languageCode: stringSplit[0],
//              countryCode: stringSplit[1],
//              scriptCode: item.language));
//        } else {
//          supportedLocales.add(Locale.fromSubtags(
//              languageCode: item.code, scriptCode: item.language));
//        }
//      }
//      return supportedLocales;
//    }
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
  bool shouldReload(AppLocalizationDelegate old) => this != old;

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
