import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nekadarparamvar/core/init/cache/local.dart';
import 'package:nekadarparamvar/core/init/helper/translate.dart';
import 'package:nekadarparamvar/core/init/localization/locale_keys.g.dart';
import 'package:nekadarparamvar/core/init/themes/default.dart';
import 'package:nekadarparamvar/core/init/themes/other.dart';
import 'package:nekadarparamvar/core/provider/data.dart';
import 'package:nekadarparamvar/core/provider/changable.dart';
import 'package:nekadarparamvar/screen/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataprovider = Provider.of<DataProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  getText(LocaleKeys.settings),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
          tile(context, [getText(LocaleKeys.language), 'English', 'Türkçe'],
              false),
          tile(
              context,
              [
                getText(LocaleKeys.theme),
                getText(LocaleKeys.light),
                getText(LocaleKeys.dark)
              ],
              true),
          listtile(
              context,
              [
                getText(LocaleKeys.fetchTime),
                dataprovider.fetchTime.toString()
              ],
              IconButton(
                onPressed: () {
                  dataprovider.prepareData();
                },
                icon: Icon(Icons.refresh),
                color: Colors.white,
              )),
          mainCurrencyTile(),
          listtile(
              context,
              [getText(LocaleKeys.service), 'freecurrencyapi'],
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.chrome,
                  size: 24,
                ),
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  FutureBuilder<String> mainCurrencyTile() {
    return FutureBuilder<String>(
        future: Local().getMainCurrency(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return listtile(
                context,
                [getText(LocaleKeys.mainCurrency), snapshot.data ?? ''],
                IconButton(
                  onPressed: () async {
                    context.read<DataProvider>().searchResult.clear();
                    await showDialog(
                        context: context,
                        builder: (context) => Dialog(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: SizedBox(
                              height: 68.h,
                              width: 85.w,
                              child: SplashScreen()
                                  .inside(context, isDataFetched: true),
                            )));
                  },
                  icon: Icon(Icons.arrow_drop_down),
                  color: Colors.white,
                ));
          }
        });
  }
}

Widget tile(context, List<String> list, bool isTheme) {
  return Card(
    child: Wrap(children: [
      Text(
        list[0],
        style: Theme.of(context).textTheme.subtitle1,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildColumn(context, list[1], isTheme),
          buildColumn(context, list[2], isTheme)
        ],
      )
    ]),
  );
}

Widget listtile(BuildContext context, List<String> list, IconButton icon) {
  return Card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(list[0], style: Theme.of(context).textTheme.subtitle1),
        Row(
          children: [
            Text(list[1], style: Theme.of(context).textTheme.headline6),
            icon
          ],
        )
      ],
    ),
  );
}

Widget buildColumn(context, Object option, bool isTheme) {
  var themeprovider = Provider.of<ChangableProvider>(context, listen: true);
  var all = themeprovider.getAll(context);
  return Column(
    children: [
      Radio<Object>(
        activeColor: Colors.white,
        value: isTheme ? all[1] : all[0],
        groupValue: isTheme
            ? (option as String).contains('Koyu') || (option).contains('Dark')
                ? defaultTheme
                : otherTheme
            : option,
        onChanged: (value) {
          isTheme
              ? themeprovider.changeTheme()
              : themeprovider.changeLanguage(context);
        },
      ),
      Text(
        option.toString(),
        style: Theme.of(context).textTheme.subtitle2,
      )
    ],
  );
}
