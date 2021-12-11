import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class CurrencyTile extends StatelessWidget {
  final MapEntry<String, dynamic> wealth;
  final bool? isRaised;
  const CurrencyTile({Key? key, required this.wealth, this.isRaised})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var realValue = 1 / wealth.value;
    Icon icon = isRaised == null
        ? const Icon(
            FontAwesomeIcons.equals,
            color: Colors.blue,
            size: 24,
          )
        : isRaised!
            ? const Icon(
                Icons.arrow_circle_up_outlined,
                color: Colors.green,
              )
            : const Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.red,
              );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          name(wealth.key, context),
          const Expanded(flex: 3, child: SizedBox()),
          rise(icon),
          const Expanded(flex: 1, child: SizedBox()),
          box(realValue.toStringAsFixed(4), context),
        ],
      ),
    );
  }

  Widget name(text, context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget box(text, context) {
    return SizedBox(
      height: 8.h,
      width: 17.w,
      child: Center(
          child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
        overflow: TextOverflow.ellipsis,
      )),
    );
  }

  Widget rise(icon) {
    return SizedBox(
      height: 8.h,
      width: 15.w,
      child: icon,
    );
  }
}
