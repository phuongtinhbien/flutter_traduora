library flutter_traduora;

import 'dart:ui';

import 'package:flutter/widgets.dart';

class Traduora {
  final String traduoraUrl;
  final String grantType;
  final String projectId;
  final String clientId;
  final String secretKey;

  static Traduora current;

  static String defaultLocale;
  static String systemLocale = 'en_US';

  Traduora(
      {this.traduoraUrl,
      this.grantType,
      this.projectId,
      this.clientId,
      this.secretKey});

  static initalize(
      {traduoraUrl, grantType, projectId, clientId, secretKey}) {
    if (current == null) {
      current = new Traduora(
          traduoraUrl: traduoraUrl,
          grantType: grantType,
          projectId: projectId,
          clientId: clientId,
          secretKey: secretKey);
    }
  }

  static Traduora of(BuildContext context) {
    return Localizations.of<Traduora>(context, Traduora);
  }

  static Future<Traduora> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = canonicalizedLocale(name);
//    return initializeMessages(localeName).then((_) {
//      Traduora.defaultLocale = localeName;
//
//      return Traduora.current;
//    });
  }

  static canonicalizedLocale(String aLocale) {
    if (aLocale == null) return getCurrentLocale();
    if (aLocale == 'C') return 'en_ISO';
    if (aLocale.length < 5) return aLocale;
    if (aLocale[2] != '-' && (aLocale[2] != '_')) return aLocale;
    var region = aLocale.substring(3);
    // If it's longer than three it's something odd, so don't touch it.
    if (region.length <= 3) region = region.toUpperCase();
    return '${aLocale[0]}${aLocale[1]}_$region';
  }

  static String getCurrentLocale() {
    defaultLocale ??= systemLocale;
    return defaultLocale;
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Traduora> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi', countryCode: 'VN'),
      Locale.fromSubtags(languageCode: 'en'),
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
