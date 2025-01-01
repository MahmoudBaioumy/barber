import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/Home/widgets/imagebuilda.dart';
import 'package:gap/gap.dart';

class WaveView extends StatelessWidget {
  const WaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            ' حلآقات الوفي',
            style: getTitelstyle(color: AppColor.white1color, fontSize: 20),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.white1color,
            ),
          )),
      body: const Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Rowimage(
                image1: 'assets/wa1.jpg',
                image2: 'assets/wa2.jpg',
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/wa3.jpg',
                image2: 'assets/wa4.jpg',
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/wa5.jpg',
                image2: 'assets/wa6.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
