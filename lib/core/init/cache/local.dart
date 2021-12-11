import 'package:shared_preferences/shared_preferences.dart';

class Local {
  void setMainCurrency(String current) async {
    var instance = await SharedPreferences.getInstance();
    await instance.setString('mainCurrency', current);
  }

  Future<String> getMainCurrency() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getString('mainCurrency') ?? '';
  }
}
