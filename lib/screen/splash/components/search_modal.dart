import 'package:flutter/material.dart';
import 'package:nekadarparamvar/core/init/helper/translate.dart';
import 'package:nekadarparamvar/core/init/localization/locale_keys.g.dart';
import 'package:nekadarparamvar/core/provider/data.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

SizedBox searchModal(BuildContext context) {
  var dataprovider = context.read<DataProvider>();
  var controller = TextEditingController();
  return SizedBox(
      height: 7.h,
      width: 10.w,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            maxLength: 3,
            textCapitalization: TextCapitalization.characters,
            style: TextStyle(color: Colors.black),
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    dataprovider.fillSearch(controller.text);
                    controller.clear();
                    Navigator.pop(context, 'search modal');
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                labelText: getText(LocaleKeys.code)),
          ),
        ),
      ));
}
