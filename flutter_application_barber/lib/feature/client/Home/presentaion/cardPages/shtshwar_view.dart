import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/Home/widgets/imagebuilda.dart';
import 'package:gap/gap.dart';

class ShtshwarView extends StatelessWidget {
  const ShtshwarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            ' حلآقات الآستشوار',
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
                image1: 'assets/sh1.jpg',
                
                image2: 'assets/sh2.jpg',
                
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/sh3.jpg',
               
                image2: 'assets/sh4.jpg',
                
              ),
              Gap(20),
              Rowimage(
                image1: 'assets/sh5.jpg',
                
                image2: 'assets/sh6.jpg',
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
