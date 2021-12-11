import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nekadarparamvar/core/init/localization/lang_constants.dart';
import 'package:nekadarparamvar/core/init/themes/default.dart';
import 'package:nekadarparamvar/core/init/themes/other.dart';

class ChangableProvider extends ChangeNotifier {
  var currentTheme = defaultTheme;
  var currentLanguage = '';

  void changeTheme() {
    currentTheme = currentTheme == defaultTheme ? otherTheme : defaultTheme;
    notifyListeners();
  }

  List getAll(BuildContext context) {
    var localization = EasyLocalization.of(context)!;
    currentLanguage = localization.currentLocale == LangConstants.EN_LOCALE
        ? 'English'
        : 'Türkçe';

    return [currentLanguage, currentTheme];
  }

  void changeLanguage(BuildContext context) {
    var localization = EasyLocalization.of(context)!;
    if (localization.currentLocale! == LangConstants.EN_LOCALE) {
      localization.setLocale(LangConstants.TR_LOCALE);
      currentLanguage = 'Türkçe';
    } else {
      localization.setLocale(LangConstants.EN_LOCALE);
      currentLanguage = 'English';
    }
    notifyListeners();
  }
}
