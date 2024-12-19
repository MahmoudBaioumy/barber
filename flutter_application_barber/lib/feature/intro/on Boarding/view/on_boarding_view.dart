import 'package:flutter/material.dart';
import 'package:flutter_application_barber/feature/intro/on%20Boarding/presentaion/widgets/on_boarding_body.dart';

class onboardingview extends StatefulWidget {
  const onboardingview({super.key});

  @override
  State<onboardingview> createState() => _onboardingviewState();
}

class _onboardingviewState extends State<onboardingview> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnBoardingViewBody(),
    );
  }
}
