import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:gap/gap.dart';

class Container_build extends StatelessWidget {
  const Container_build({
    super.key,
    required this.BoxDecorationcolor,
    required this.CircleAvatarcolor,
    required this.titel,
  });
  final Color BoxDecorationcolor;
  final Color CircleAvatarcolor;
  final String titel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10),
      decoration: BoxDecoration(
        color: BoxDecorationcolor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: AppColor.lightBlue.withOpacity(.8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: CircleAvatar(
                backgroundColor: CircleAvatarcolor,
                radius: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Column(
                children: [
                  const Gap(80),
                  Text(titel,
                      textAlign: TextAlign.center,
                      style: getTitelstyle(
                          color: AppColor.white1color, fontSize: 18)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
