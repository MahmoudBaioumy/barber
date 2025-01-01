import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/Home/widgets/imagebuilda.dart';
import 'package:gap/gap.dart';

class ClassicView extends StatelessWidget {
  const ClassicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'حلآقات كلآسيك',
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
                image1: 'assets/classic2.jpg',
                
                image2: 'assets/classic3.jpg',
                
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/classic4.jpg',
                
                image2: 'assets/classic5.jpg',
                
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/classic6.jpg',
                
                image2: 'assets/classic1.jpg',
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
