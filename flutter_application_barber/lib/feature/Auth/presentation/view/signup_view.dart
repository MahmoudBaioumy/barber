import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/function/email_vaildate.dart';
import 'package:flutter_application_barber/core/function/routing.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/Custom_dialogs.dart';
import 'package:flutter_application_barber/core/widgets/custom_buttons.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view/compelet_data.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view/login_view.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view_model/auth_cubit.dart';
import 'package:flutter_application_barber/feature/Auth/presentation/view_model/auth_states.dart';
import 'package:flutter_application_barber/feature/client/Home/nav_bar/view/nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class signup_viwe extends StatefulWidget {
  const signup_viwe({super.key, required this.index});
  final int index;

  @override
  State<signup_viwe> createState() => _signup_viweState();
}

class _signup_viweState extends State<signup_viwe> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String handleUserType(int index) {
    return widget.index == 0 ? 'حلاق' : 'عميل';
  }

  @override
  bool isVisable = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is signupSuccessStates) {
          if (widget.index == 0) {
            pushAndRemoveUntil(context, const CompeletData());
          } else {
            pushAndRemoveUntil(context, const NavBar_client());
          }
        } else if (state is signupErorrStates) {
          Navigator.pop(context);
          showErrorDialog(context, state.Erorr);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/back.jpg',
                      height: 260,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      'سجل حساب جديد كـ "${handleUserType(widget.index)}"',
                      style: getTitelstyle(),
                    ),
                    const Gap(20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: _displayName,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColor.bluecolor,
                          ),
                          hintText: 'الاسم',
                          hintStyle: getsmallstyle()),
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل الاسم';
                        return null;
                      },
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: _emailController,
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'example12@gmail.com',
                        hintStyle: getsmallstyle(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColor.bluecolor,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الايميل ';
                        } else if (!emailValidate(value)) {
                          return 'من فضلك ادخل الاميل صحيحا';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: _passwordController,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: AppColor.blackcolor),
                      obscureText: isVisable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: '********',
                        hintStyle: getsmallstyle(),
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
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل كلمه السر ';
                        return null;
                      },
                    ),
                    const Gap(5),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(top: 5, right: 10),
                      child: Text(
                        'نسيت كلمة السر ؟',
                        style: getsmallstyle(color: AppColor.blackcolor),
                      ),
                    ),
                    const Gap(20),
                    CustomButton(
                        width: double.infinity,
                        height: 50,
                        background: AppColor.bluecolor,
                        radius: 25,
                        text: 'تسجيل حساب',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.index == 0) {
                              context.read<AuthCubit>().RegisterOnwer(
                                  _displayName.text,
                                  _emailController.text,
                                  _passwordController.text);
                            } else {
                              context.read<AuthCubit>().RegisterClient(
                                  _displayName.text,
                                  _emailController.text,
                                  _passwordController.text);
                            }
                          }
                        }),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' لدي حساب ؟',
                          style: getBodystyle(fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {
                              pushwithReplacement(
                                  context,
                                  LoginView(
                                    index: widget.index,
                                  ));
                            },
                            child: Text(
                              'سجل دخول',
                              style: getTitelstyle(fontSize: 14),
                            ))
                      ],
                    )
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
