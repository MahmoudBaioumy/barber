import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';

class OwnerProfile extends StatefulWidget {
  const OwnerProfile({super.key});

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Owner profile',
        style: getTitelstyle(color: AppColor.blackcolor),
      )),
    );
  }
}
