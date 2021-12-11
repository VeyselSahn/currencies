import 'package:flutter/material.dart';
import 'package:nekadarparamvar/core/constant/texts.dart';
import 'package:nekadarparamvar/core/provider/data.dart';
import 'package:provider/provider.dart';
import 'package:nekadarparamvar/screen/splash/components/search_modal.dart';

AppBar normal(BuildContext context) {
  var dataprovider = context.watch<DataProvider>();
  return AppBar(
    actions: [
      dataprovider.searchResult.isEmpty
          ? SizedBox(
              height: 0,
            )
          : IconButton(
              onPressed: () {
                dataprovider.searchClear();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              )),
      IconButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => searchModal(context),
            );
          },
          icon: const Icon(Icons.search))
    ],
    title: Text(
      TextConstant().title,
      style: const TextStyle(
        fontSize: 16,
      ),
    ),
  );
}
