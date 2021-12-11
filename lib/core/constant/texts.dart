class TextConstant {
  String title = 'Currencies';
  String source = 'https://freecurrencyapi.net';
}

class ApiConstants {
  static final instance = ApiConstants();
  String baseUrl = 'https://freecurrencyapi.net/api/v2/historical?';
  String apiKey = '789d8810-54f9-11ec-a881-45ca55c1945f';
  Map<String, dynamic> getParams(String today, yesterday, currency) {
    return {
      "apikey": apiKey,
      "base_currency": currency,
      "date_from": yesterday,
      "date_to": today
    };
  }
}
