import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnerView extends StatefulWidget {
  const OwnerView({super.key});

  @override
  State<OwnerView> createState() => _OwnerViewState();
}

class _OwnerViewState extends State<OwnerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              splashRadius: 20,
              icon:
                  Icon(Icons.notifications_active, color: AppColor.white1color),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
        title: Text(
          'قِصَّتِي',
          style: getTitelstyle(color: AppColor.white1color, fontSize: 22)
              .copyWith(fontFamily: GoogleFonts.notoKufiArabic().fontFamily),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: 'مرحبا، ',
                    style: getBodystyle(fontSize: 22),
                  ),
                  TextSpan(
                    text: 'محمود بيومي',
                    style: getTitelstyle(fontSize: 22),
                  ),
                ],
              )),
              const Gap(10),
              Text(
                'الأن كن جزء من تحسين مظهرهم.',
                style: getTitelstyle(color: AppColor.blackcolor, fontSize: 28),
              ),
              const Gap(50),
              Center(
                  child: Image.asset(
                'assets/back.jpg',
                width: 400,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
