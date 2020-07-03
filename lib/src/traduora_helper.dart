import 'dart:collection';

import 'package:flutter_traduora/src/manager/traduora_manager.dart';

typedef Future<dynamic> LibraryLoader();

class TraduoraHelper {

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
    TraduoraManager.defaultLocale ??= TraduoraManager.systemLocale;
    return TraduoraManager.defaultLocale;
  }
  static String getDefaultLocale() {
    return TraduoraManager.defaultLocale;
  }

  static String verifiedLocale(
      String newLocale, bool Function(String) localeExists,
      {String Function(String) onFailure = _throwLocaleError}) {
    if (newLocale == null) {
      return verifiedLocale(getCurrentLocale(), localeExists,
          onFailure: onFailure);
    }
    if (localeExists(newLocale)) {
      return newLocale;
    }
    for (var each in [
      canonicalizedLocale(newLocale),
      shortLocale(newLocale),
      'fallback'
    ]) {
      if (localeExists(each)) {
        return each;
      }
    }
    return onFailure(newLocale);
  }

  static String _throwLocaleError(String localeName) {
    throw ArgumentError('Invalid locale "$localeName"');
  }

  static String shortLocale(String aLocale) {
    if (aLocale.length < 2) return aLocale;
    return aLocale.substring(0, 2).toLowerCase();
  }
}
