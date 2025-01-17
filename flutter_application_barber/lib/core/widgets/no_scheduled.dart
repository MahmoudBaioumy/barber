import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_svg/svg.dart';

class NoScheduledWidget extends StatelessWidget {
  const NoScheduledWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/no_scheduled owner.svg', width: 250),
          Text('لا يوجد حجوزات لديك', style: getBodystyle()),
        ],
      ),
    );
  }
}
