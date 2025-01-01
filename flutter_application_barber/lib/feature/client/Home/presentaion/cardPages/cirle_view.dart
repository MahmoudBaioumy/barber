import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/Home/widgets/imagebuilda.dart';
import 'package:gap/gap.dart';

class CirleView extends StatelessWidget {
  const CirleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'حلآقات كيرلي',
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
                image1: 'assets/cr1.jpg',
                image2: 'assets/cr2.jpg',
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/cr3.jpg',
                image2: 'assets/cr4.jpg',
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/cr5.jpg',
                image2: 'assets/cr6.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
