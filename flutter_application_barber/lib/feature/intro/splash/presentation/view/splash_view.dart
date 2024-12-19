import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/size_config.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/intro/on%20Boarding/view/on_boarding_view.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin{
  AnimationController? animationController;
  Animation<double>? fadingAnimation;
  @override
  void initState() {
    

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const onboardingview(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset('assets/logo.json'),
            const Gap(5),
            Text(
              'احجز عند حلاقك المفضل دلوقتي !',
              style: getBodystyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
