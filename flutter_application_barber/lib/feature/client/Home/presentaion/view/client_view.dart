import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/function/routing.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/Home/presentaion/cardPages/buzzcut_view.dart';
import 'package:flutter_application_barber/feature/client/Home/presentaion/cardPages/cirle_view.dart';
import 'package:flutter_application_barber/feature/client/Home/presentaion/cardPages/classic_view.dart';
import 'package:flutter_application_barber/feature/client/Home/presentaion/cardPages/shtshwar_view.dart';
import 'package:flutter_application_barber/feature/client/Home/presentaion/cardPages/wave_view.dart';
import 'package:flutter_application_barber/feature/client/Home/presentaion/view/search_home_view.dart';
import 'package:flutter_application_barber/feature/client/Home/widgets/card_build.dart';
import 'package:flutter_application_barber/feature/client/Home/widgets/top_rated_list.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  final TextEditingController _barbarName = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

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
      //////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                    text: user?.displayName,
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
                                        builder: (context) => SearchHomeView(
                                          searchKey: _barbarName.text,
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
                                  builder: (context) => SearchHomeView(
                                    searchKey: _barbarName.text,
                                  ),
                                ),
                              );
                      },
                    );
                  },
                ),
              ),
              const Gap(20),
              // ----------------  SpecialistsWidget --------------------,
              Text(
                'الحلآقات',
                style: getTitelstyle(),
              ),
              const Gap(5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //////***********************************//buzz cut*************************////////////////////////////////////////////
                    GestureDetector(
                      onTap: () {
                        push(context, const BuzzcutView());
                      },
                      child: Container_build(
                        BoxDecorationcolor: AppColor.lightBlue,
                        CircleAvatarcolor: AppColor.lightBlue,
                        titel: 'buzz Cut',
                      ),
                    ),
                    ///////////////**///****************/كلاسيك***********************/////////////////////////////////***
                    GestureDetector(
                      onTap: () {
                        push(context, const ClassicView());
                      },
                      child: Container_build(
                          BoxDecorationcolor: AppColor.lightGreen,
                          CircleAvatarcolor: AppColor.lightGreen,
                          titel: 'حلآقه كلاسيك'),
                    ),
////////////////////*******حلاقه الاستشوار**********//////////////////////////////////////////// */
                    GestureDetector(
                      onTap: () {
                        push(context, const ShtshwarView());
                      },
                      child: Container_build(
                        BoxDecorationcolor: AppColor.lightOrange,
                        CircleAvatarcolor: AppColor.lightOrange,
                        titel: ' حلاقه الاستشوار',
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        push(context, const WaveView());
                      },
                      child: Container_build(
                          BoxDecorationcolor: AppColor.bluecolor,
                          CircleAvatarcolor: AppColor.bluecolor,
                          titel: 'حلآقه الوفي'),
                    ),

                    ///////////////************************************** */
                    GestureDetector(
                      onTap: () {
                        push(context, const CirleView());
                      },
                      child: Container_build(
                        BoxDecorationcolor: AppColor.purpleLight,
                        CircleAvatarcolor: AppColor.purpleLight,
                        titel: 'حلاقه الكيرلي',
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              //////////-*****************************************//TopRate/**************************************************** */
              Text(
                "الأعلي تقييماً",
                textAlign: TextAlign.center,
                style: getTitelstyle(fontSize: 16),
              ),
              const Gap(10),
              const TopRatedList(),
            ],
          ),
        ),
      ),
    );
  }
}
