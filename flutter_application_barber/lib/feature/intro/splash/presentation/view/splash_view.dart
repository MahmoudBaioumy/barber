import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/function/routing.dart';
import 'package:flutter_application_barber/core/utils/size_config.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/Home/nav_bar/view/nav_bar.dart';
import 'package:flutter_application_barber/feature/intro/on%20Boarding/view/on_boarding_view.dart';
import 'package:flutter_application_barber/feature/owner/navbar/nav_bar.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      pushwithReplacement(
          context,
          FirebaseAuth.instance.currentUser != null
              ? FirebaseAuth.instance.currentUser?.photoURL == '0'
                  ? const NavBar_owner() //Update with doctor nav
                  : const NavBar_client()
              // Todo: using caching
              // TODO: if onboarding is not done, ==> onboarding view
              // TODO: else ==> welcome View
              : const onboardingview());
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
