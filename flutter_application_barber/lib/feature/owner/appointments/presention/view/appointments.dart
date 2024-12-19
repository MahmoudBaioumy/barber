import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'موأعيد الحجز',
          style: getTitelstyle(color: AppColor.white1color, fontSize: 22),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Gap(130),
            SvgPicture.asset(
              'assets/no_scheduled owner.svg',
              width: 280,
            ),
            Text(
              'لآ يوجد حجوزأت قأدمه',
              style: getTitelstyle(
                  color: AppColor.blackcolor,
                  fontSize: 25,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
