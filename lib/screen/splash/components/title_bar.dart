import 'package:flutter/material.dart';
import 'package:nekadarparamvar/core/init/helper/translate.dart';
import 'package:nekadarparamvar/core/init/localization/locale_keys.g.dart';
import 'package:nekadarparamvar/core/provider/splash.dart';
import 'package:sizer/sizer.dart';

import 'search_modal.dart';

Widget titleBar(SplashProvider splashProvider, BuildContext context) {
  return SizedBox(
    height: 7.h,
    width: 100.w,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          Text(
            getText(LocaleKeys.mainCurrency),
            style: Theme.of(context).textTheme.headline6,
          ),
          InkWell(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return searchModal(context);
                },
              );
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
    ),
  );
}
