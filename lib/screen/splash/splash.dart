import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nekadarparamvar/core/init/cache/local.dart';
import 'package:nekadarparamvar/core/init/helper/translate.dart';
import 'package:nekadarparamvar/core/init/localization/locale_keys.g.dart';
import 'package:nekadarparamvar/core/provider/data.dart';
import 'package:nekadarparamvar/core/provider/splash.dart';
import 'package:nekadarparamvar/core/service/api.dart';
import 'package:nekadarparamvar/screen/main/main_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import 'components/title_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget splash = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splash_background.jpg'),
              fit: BoxFit.cover)),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Local().getMainCurrency(),
        builder: (futurecontext, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.data == '') {
              return Stack(
                children: [
                  splash,
                  Center(
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: 85.w,
                      height: 68.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: inside(context, isDataFetched: false),
                    ),
                  )
                ],
              );
            } else {
              return MainScreen(
                dataFetched: false,
              );
            }
          }
        },
      ),
    );
  }

  Widget inside(BuildContext context, {required bool isDataFetched}) {
    var splashprovider = context.watch<SplashProvider>();
    var dataprovider = context.watch<DataProvider>();
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 3),
      children: [
        titleBar(splashprovider, context),
        Divider(
          color: Colors.white,
        ),
        isDataFetched
            ? SizedBox(
                height: 50.h,
                width: 85.w,
                child: listview(
                    dataprovider.searchResult.entries.isEmpty
                        ? dataprovider.todayResults
                        : dataprovider.searchResult,
                    splashprovider))
            : currenyList(dataprovider, splashprovider),
        Center(
          child: ElevatedButton(
              onPressed: () async {
                Local().setMainCurrency(splashprovider.mainCurrency);
                if (!isDataFetched) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(
                                dataFetched:
                                    splashprovider.mainCurrency == 'TRY'
                                        ? true
                                        : false,
                              )),
                      (route) => false);
                } else {
                  Navigator.pop(context, '');
                  dataprovider.prepareData();
                }

                dataprovider.searchResult.clear();
              },
              child: Text(
                  '${getText(LocaleKeys.apply)} (${splashprovider.mainCurrency})')),
        )
      ],
    );
  }

  Widget currenyList(DataProvider dataprovider, SplashProvider splashprovider) {
    return SizedBox(
      width: 85.w,
      height: 50.h,
      child: FutureBuilder<Response<dynamic>>(
          future: Api().getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  dataprovider.fillLists(snapshot.data!);
                });
              }
              return dataprovider.searchResult.isEmpty
                  ? listview(dataprovider.todayResults, splashprovider)
                  : listview(dataprovider.searchResult, splashprovider);
            }
          }),
    );
  }

  Widget listview(
      Map<String, dynamic> resultMap, SplashProvider splashprovider) {
    return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var item = resultMap.keys.elementAt(index);
          return ListTile(
            leading: Text(
              item,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: Radio<String>(
              activeColor: Colors.green,
              fillColor: MaterialStateProperty.all(Colors.white),
              value: item,
              groupValue: splashprovider.mainCurrency,
              onChanged: (value) {
                splashprovider.setCurrency(value.toString());
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: resultMap.entries.length);
  }
}
