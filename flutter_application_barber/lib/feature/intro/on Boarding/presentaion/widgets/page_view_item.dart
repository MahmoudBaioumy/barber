import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/size_config.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/space_widget.dart';

class pageviewitem extends StatelessWidget {
  const pageviewitem({super.key, this.titel, this.subtitel, this.image});

  final String? titel;
  final String? subtitel;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        const heigthspace(18),
        SizedBox(
            height: SizeConfig.defaultSize! * 20, child: Image.asset(image!)),
        const heigthspace(2.5),
        Text(
          titel!,
          style: getBodystyle(color: AppColor.bluecolor, fontSize: 22),
          textAlign: TextAlign.left,
        ),
        const heigthspace(1),
        Text(
          subtitel!,
          style: getsmallstyle(fontSize: 15, color: AppColor.greycolor),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
