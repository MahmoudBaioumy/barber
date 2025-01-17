import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/function/email_vaildate.dart';
import 'package:flutter_application_barber/core/function/routing.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/size_config.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/Custom_dialogs.dart';
import 'package:flutter_application_barber/core/widgets/custom_buttons.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view/compelet_data.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view/signup_view.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view_model/auth_cubit.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view_model/auth_states.dart';
import 'package:flutter_application_barber/feature/client/Home/nav_bar/view/nav_bar.dart';
import 'package:flutter_application_barber/feature/owner/navbar/nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.index});
  final int index;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisable = true;

  String handleUserType() {
    return widget.index == 0 ? 'حلاق' : 'عميل';
  }

  ///*******************************//////signInWithGoogle/////////////********************************** */
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      (widget.index == 0)
          ? pushAndRemoveUntil(context, const CompeletData())
          : pushAndRemoveUntil(context, const NavBar_client());
      return const SizedBox();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.role == '0') {
            pushAndRemoveUntil(context, const NavBar_owner());
          } else {
            pushAndRemoveUntil(context, const NavBar_client());
          }
        } else if (state is LoginErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/back.jpg',
                      height: SizeConfig.defaultSize! * 26,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'سجل دخول الان كـ "${handleUserType()}"',
                      style: getTitelstyle(),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: 'example12@gmail.com',
                        hintStyle: getBodystyle(color: AppColor.greycolor),
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: AppColor.bluecolor,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الايميل';
                        } else if (!emailValidate(value)) {
                          return 'من فضلك ادخل الايميل صحيحا';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.end,
                      style: TextStyle(color: AppColor.blackcolor),
                      obscureText: isVisable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: '********',
                        hintStyle: getBodystyle(color: AppColor.greycolor),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: Icon(
                              (isVisable)
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off_rounded,
                              color: AppColor.bluecolor,
                            )),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColor.bluecolor,
                        ),
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                        return null;
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(top: 5, right: 10),
                      child: Text(
                        'نسيت كلمة السر ؟',
                        style: getsmallstyle(),
                      ),
                    ),
                    const Gap(20),
                    CustomButton(
                      width: 500,
                      background: AppColor.bluecolor,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context.read<AuthCubit>().Login(
                              _emailController.text, _passwordController.text);
                        }
                      },
                      text: "تسجيل الدخول",
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لدي حساب ؟',
                          style: getBodystyle(color: AppColor.blackcolor),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => signup_viwe(
                                  index: widget.index,
                                ),
                              ));
                            },
                            child: Text(
                              'سجل الان',
                              style: getBodystyle(color: AppColor.bluecolor),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(10),
                        Icon(
                          FontAwesomeIcons.googlePlusG,
                          color: AppColor.redcolor,
                        ),
                        TextButton(
                            onPressed: () {
                              signInWithGoogle();
                            },
                            child: Text(
                              'سجل بستخدأم',
                              style: getBodystyle(color: AppColor.bluecolor),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
