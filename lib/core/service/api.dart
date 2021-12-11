import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:nekadarparamvar/core/constant/texts.dart';
import 'package:nekadarparamvar/core/init/cache/local.dart';

class Api {
  late Dio dio;

  Future<Response> getData() async {
    try {
      final df = DateFormat('yyyy-MM-dd');
      var dateTo = df.format(DateTime.now());
      var currency = await Local().getMainCurrency();
      var dateFrom =
          df.format(DateTime.now().subtract(const Duration(days: 2)));
      dio = Dio(BaseOptions(
          baseUrl: ApiConstants.instance.baseUrl,
          queryParameters: ApiConstants.instance
              .getParams(dateTo, dateFrom, currency == '' ? 'TRY' : currency)));
      return await dio.get('');
    } catch (e) {
      throw Exception(e);
    }
  }
}
