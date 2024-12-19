import 'package:flutter/material.dart';
import 'package:flutter_application_barber/feature/intro/welcomebage/presentaion/widget/welcomebodyview.dart';

class WelcomePageView extends StatelessWidget {
  const WelcomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeBodyView(),
    );
  }
}
