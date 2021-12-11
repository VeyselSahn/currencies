import 'package:flutter/material.dart';
import 'package:nekadarparamvar/core/init/helper/translate.dart';
import 'package:nekadarparamvar/core/init/localization/locale_keys.g.dart';
import 'package:nekadarparamvar/core/provider/data.dart';
import 'package:nekadarparamvar/screen/currenies/component/currency_box.dart';
import 'package:provider/provider.dart';

class Currenies extends StatelessWidget {
  const Currenies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, data, child) {
      Map<String, dynamic> currencies;
      if (data.searchResult.isNotEmpty) {
        currencies = data.searchResult;
      } else {
        currencies = data.todayResults;
      }

      return RefreshIndicator(
        onRefresh: () async => await data.prepareData(),
        child: data.loading
            ? Center(
                child: Text(
                  getText(LocaleKeys.loading),
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var value = currencies.entries.elementAt(index);
                  var yesterdayValue = data.yesterdayResults[value.key];
                  bool? isRaised;
                  if (value.value > yesterdayValue) {
                    isRaised = true;
                  } else if (value.value == yesterdayValue) {
                  } else {
                    isRaised = false;
                  }
                  return CurrencyTile(
                    wealth: value,
                    isRaised: isRaised,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: currencies.keys.length),
      );
    });
  }
}
