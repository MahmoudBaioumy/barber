import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_barber/core/function/routing.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/size_config.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/custom_buttons.dart';
import 'package:flutter_application_barber/core/widgets/custom_indector.dart';
import 'package:flutter_application_barber/feature/intro/on%20Boarding/presentaion/widgets/custom_page_view.dart';
import 'package:flutter_application_barber/feature/intro/welcomebage/view/welcom_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController? pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        custompageview(
          pageController: pageController,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: SizeConfig.defaultSize! * 24,
          child: CustomIndictor(
            dotsIndex: pageController!.hasClients ? pageController?.page : 0,
          ),
        ),
        Visibility(
          visible: pageController!.hasClients
              ? (pageController?.page == 2 ? false : true)
              : true,
          child: Positioned(
            top: SizeConfig.defaultSize! * 10,
            right: 32,
            child: GestureDetector(
              onTap: () {
                push(context, const WelcomePageView());
              },
              child: Text(
                'تخطي',
                style: getBodystyle(color: AppColor.bluecolor),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Positioned(
          left: SizeConfig.defaultSize! * 10,
          right: SizeConfig.defaultSize! * 10,
          bottom: SizeConfig.defaultSize! * 10,
          child: pageController!.hasClients
              ? (pageController?.page == 2)
                  ? CustomButton(
                      text: 'هيا بنا',
                      onPressed: () {
                        pushwithReplacement(context, const WelcomePageView());
                      },
                      background: AppColor.bluecolor,
                      height: 60,
                    )
                  : const SizedBox()
              : const SizedBox(),
        ),
      ],
    );
  }
}
