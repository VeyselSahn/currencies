import 'package:nekadarparamvar/core/provider/data.dart';
import 'package:nekadarparamvar/core/provider/splash.dart';
import 'package:nekadarparamvar/core/provider/changable.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static Providers? _instance;
  static Providers? get instance {
    _instance ??= Providers._init();
    return _instance;
  }

  Providers._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (_) => DataProvider()),
    ChangeNotifierProvider(create: (_) => ChangableProvider()),
    ChangeNotifierProvider(create: (_) => SplashProvider()),
  ];
}
