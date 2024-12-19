import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/search/presentaion/view/search_view.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  final TextEditingController _barbarName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'قِصَّتِي',
          style: getTitelstyle(color: AppColor.white1color, fontSize: 24)
              .copyWith(fontFamily: GoogleFonts.notoKufiArabic().fontFamily),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              splashRadius: 20,
              icon:
                  Icon(Icons.notifications_active, color: AppColor.white1color),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: 'مرحبا، ',
                    style: getBodystyle(fontSize: 20),
                  ),
                  TextSpan(
                    text: 'محمود بيومي',
                    style: getTitelstyle(fontSize: 20),
                  ),
                ],
              )),
              const Gap(10),
              Text(
                'أحجز الأن وكن مظهرك جذاب دائما.',
                style: getTitelstyle(color: AppColor.blackcolor, fontSize: 28),
              ),
              ///////////////////search Bar/////////////////////////////////////////////////
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    )
                  ],
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.send,
                  controller: _barbarName,
                  decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintStyle: getBodystyle(fontSize: 18),
                    filled: true,
                    hintText: 'ابحث عن حلاقك',
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: AppColor.bluecolor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: IconButton(
                        iconSize: 20,
                        splashRadius: 20,
                        color: Colors.white,
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(
                            () {
                              _barbarName.text.isEmpty
                                  ? Container()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SearchView(
                                            //   searchKey: _barbarName.text,
                                            ),
                                      ),
                                    );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  style: getBodystyle(),
                  onFieldSubmitted: (String value) {
                    setState(
                      () {
                        _barbarName.text.isEmpty
                            ? Container()
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SearchView(
                                      // searchKey: _barbarName.text,
                                      ),
                                ),
                              );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
