import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/Home/widgets/imagebuilda.dart';
import 'package:gap/gap.dart';

class BuzzcutView extends StatelessWidget {
  const BuzzcutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Buzz Cut',
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
                image1: 'assets/buzz.png',
                image2: 'assets/buzz3.png',
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/buzz5.png',
                image2: 'assets/buzz2.png',
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/buzz1.png',
                image2: 'assets/buzz.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
