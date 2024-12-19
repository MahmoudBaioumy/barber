import 'package:flutter/material.dart';
import 'package:flutter_application_barber/feature/intro/on%20Boarding/presentaion/widgets/page_view_item.dart';

class custompageview extends StatelessWidget {
  const custompageview({super.key, this.pageController});
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        pageviewitem(
          image: 'assets/barber1.png',
          titel: 'أبحث عن حلاقك المفضل',
          subtitel: 'أكتشف مجموعه واسعه من الحلاقين المتميزين ',
        ),
        pageviewitem(
          image: 'assets/on2.png',
          titel: 'مواعيدك ديمأ مظبوطه',
          subtitel: 'أحجز المواعيد بضغطة زرار في أي وقت وفي أي مكان.',
        ),
        pageviewitem(
          image: 'assets/on3.png',
          titel: 'متقلقش أمان',
          subtitel: 'كن مطمئنًا لأن خصوصيتك وأمانك هما أهم أولوياتنا.',
        ),
      ],
    );
  }
}
