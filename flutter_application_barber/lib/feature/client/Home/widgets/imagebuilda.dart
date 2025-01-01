import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:gap/gap.dart';

class Rowimage extends StatelessWidget {
  const Rowimage({
    super.key,
    required this.image1,
    required this.image2,
   
  });
  final String image1;
  
  /////////////////
  final String image2;
 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                border: Border.all(color: AppColor.lightBlue)),
            child: Column(
              children: [
                Image.asset(
                  image1,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                const Gap(10),
                
              ],
            ),
          ),
        ),
        const Gap(20),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                border: Border.all(color: AppColor.lightBlue)),
            child: Column(
              children: [
                Image.asset(
                  image2,
                  width: 250,
                  height: 200,
                ),
                const Gap(10),
                
              ],
            ),
          ),
        )
      ],
    );
  }
}
