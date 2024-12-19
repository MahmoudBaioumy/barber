import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';

class CustomIndictor extends StatelessWidget {
  const CustomIndictor({super.key, required this.dotsIndex});
  final double? dotsIndex;
  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
        decorator: DotsDecorator(
            color: Colors.transparent,
            activeColor: AppColor.bluecolor,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(color: AppColor.greycolor))),
        dotsCount: 3,
        position: dotsIndex!.toInt());
  }
}
