import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view_model/auth_cubit.dart';
import 'package:flutter_application_barber/feature/intro/splash/presentation/view/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyD_HZGgQ6M7Hwo8Txrdot0R_6BY2Kv2JHI',
          appId: '1:255999044601:android:57647e3d453257c3d32b28',
          messagingSenderId: '255999044601',
          projectId: 'barbarapp-2e21f'));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColor.white1color,
            appBarTheme: AppBarTheme(
                titleTextStyle: getTitelstyle(color: AppColor.white1color),
                backgroundColor: AppColor.bluecolor,
                centerTitle: true),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: getBodystyle(),
              fillColor: AppColor.white2color,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            )),
        home: const SplashView(),
        //any page in all app will be build from rigth to left this builder Do this to make it arbic.
        builder: (context, child) {
          return Directionality(
              textDirection: TextDirection.rtl, child: child!);
        },
      ),
    );
  }
}
