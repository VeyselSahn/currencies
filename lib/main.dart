import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nekadarparamvar/core/init/localization/lang_constants.dart';
import 'package:nekadarparamvar/core/provider/providers.dart';
import 'package:nekadarparamvar/core/provider/changable.dart';
import 'package:nekadarparamvar/screen/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() async {
  await initialize();
  runApp(EasyLocalization(
      path: LangConstants.LANG_PATH,
      supportedLocales: LangConstants.SUPPORTED_LOCALE,
      saveLocale: true,
      fallbackLocale: LangConstants.EN_LOCALE,
      child: const MyApp()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.instance!.dependItems,
      builder: (context, child) => Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Currency Calculating',
          theme: Provider.of<ChangableProvider>(context, listen: true)
              .currentTheme,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
