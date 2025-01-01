import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/enum/user_type_enum.dart';
import 'package:flutter_application_barber/core/function/routing.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view/login_view.dart';
import 'package:gap/gap.dart';

class WelcomeBodyView extends StatefulWidget {
  const WelcomeBodyView({super.key});

  @override
  State<WelcomeBodyView> createState() => _WelcomeBodyViewState();
}

class _WelcomeBodyViewState extends State<WelcomeBodyView> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .8,
      child: Stack(
        children: [
          Image.asset(
            'assets/cc2.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
              top: 100,
              right: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اهلا بيك',
                    style: getTitelstyle(fontSize: 55),
                  ),
                  const Gap(5),
                  Text(
                    'سجل واحجز عند حلاقك وانت فالبيت',
                    style:
                        getBodystyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              )),
          Positioned(
              bottom: 50,
              left: 25,
              right: 25,
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: AppColor.bluecolor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.greycolor.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(5, 5),
                      )
                    ]),
                child: Column(
                  children: [
                    Text(
                      'سجل دلوقتي ك',
                      style: getBodystyle(
                          fontSize: 20,
                          color: AppColor.white1color,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(40),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            push(
                                context,
                                const LoginView(
                                  index: 0,
                                ));
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: AppColor.white2color.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'حلاق',
                                style:
                                    getTitelstyle(color: AppColor.blackcolor),
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        GestureDetector(
                          onTap: () {
                            push(
                                context,
                                const LoginView(
                                  index: 1,
                                ));
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: AppColor.white2color.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'عميل',
                                style:
                                    getTitelstyle(color: AppColor.blackcolor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
