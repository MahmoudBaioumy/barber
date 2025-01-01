import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/barbers_Card.dart';
import 'package:flutter_application_barber/core/widgets/custom_alert_dialog.dart';
import 'package:flutter_application_barber/core/widgets/custom_buttons.dart';
import 'package:flutter_application_barber/feature/client/Home/nav_bar/view/nav_bar.dart';
import 'package:flutter_application_barber/feature/client/search/data/onwer_model.dart';
import 'package:flutter_application_barber/feature/owner/profile/widgets/available_appointments.dart';
import 'package:intl/intl.dart';

class BookingView extends StatefulWidget {
  final Onwer onwer;

  const BookingView({
    super.key,
    required this.onwer,
  });

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(text: 'ادخل تاريخ الحجز');

  TimeOfDay currentTime = TimeOfDay.now();
  String? dateUTC;
  String? date_Time;

  Set<int> isSelected = {};

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  // جلب الساعات المتبقية من اليوم
  List<int> times = [];
  getAvilableTimes(selectedDate) async {
    // to clear last times when clicking date dialog
    times.clear();
    AppointmentService()
        .getAvailableAppointments(
            selectedDate, widget.onwer.startHour, widget.onwer.endHour)
        .then((avilableTimes) {
      for (var i in avilableTimes) {
        times.add(i.hour);
      }
    });
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColor.bluecolor,
            colorScheme: ColorScheme.light(primary: AppColor.bluecolor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ).then(
      (date) {
        if (date != null) {
          setState(
            () {
              // intl to format datetime
              _dateController.text = DateFormat('dd-MM-yyyy').format(date);
              dateUTC = DateFormat('yyyy-MM-dd').format(date);
              getAvilableTimes(date);
            },
          );
        }
      },
    );
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColor.white1color,
            )),
        elevation: 0,
        title: const Text(
          'احجز مع حلآقك',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              BarbersCard(
                  name: widget.onwer.name,
                  image: widget.onwer.imageUrl,
                  rating: widget.onwer.rating,
                  onPressed: () {}),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '-- ادخل بيانات الحجز --',
                        style: getTitelstyle(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'اسم العميل',
                            style: getBodystyle(color: AppColor.blackcolor),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل اسم العميل';
                        return null;
                      },
                      style: getBodystyle(),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'رقم الهاتف',
                            style: getBodystyle(color: AppColor.blackcolor),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      style: getBodystyle(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        } else if (value.length < 10) {
                          return 'يرجي ادخال رقم هاتف صحيح';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وصف الحلقه',
                            style: getBodystyle(color: AppColor.blackcolor),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      style: getBodystyle(),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'تاريخ الحجز',
                            style: getBodystyle(color: AppColor.blackcolor),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextFormField(
                            readOnly: true,
                            controller: _dateController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك ادخل تاريخ الحجز';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            style: getBodystyle(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: InkWell(
                              child: CircleAvatar(
                                backgroundColor: AppColor.bluecolor,
                                radius: 20,
                                child: const Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                selectDate(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وقت الحجز',
                            style: getBodystyle(color: AppColor.blackcolor),
                          )
                        ],
                      ),
                    ),

                    // available times chips
                    Wrap(spacing: 8.0, children: [
                      for (int i = 0; i < times.length; i++)
                        ChoiceChip(
                          backgroundColor: AppColor.white2color,
                          selectedColor: AppColor.bluecolor,
                          label: Text(
                            '${times[i].toString()}:00',
                            style: TextStyle(
                              color: isSelected.contains(i)
                                  ? AppColor.white1color
                                  : AppColor.blackcolor,
                            ),
                          ),
                          selected: isSelected.contains(i),
                          onSelected: (selected) {
                            isSelected.clear();
                            setState(() {
                              isSelected.add(i);
                              // to add 0 before hours < 10 (9:00  ===> 09:00)
                              date_Time =
                                  '${(times[i] < 10) ? '0' : ''}${times[i].toString()}:00';
                            });
                          },
                        )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomButton(
          background: AppColor.bluecolor,
          text: 'تأكيد الحجز',
          onPressed: () {
            if (_formKey.currentState!.validate() && isSelected != -1) {
              _createAppointment();
              showAlertDialog(
                context,
                title: 'تم تسجيل الحجز !',
                ok: 'اضغط للانتقال',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavBar_client(),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('pending')
        .doc()
        .set({
      'clientID': user!.email,
      'OwnerID': widget.onwer.email,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'Owner': widget.onwer.name,
      'location': widget.onwer.location,
      'date': DateTime.parse('${dateUTC!} ${date_Time!}:00'),
      'isComplete': false,
      'rating': null
    }, SetOptions(merge: true));

    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('all')
        .doc()
        .set({
      'clientID': user!.email,
      'OwnerID': widget.onwer.email,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'Owner': widget.onwer.name,
      'location': widget.onwer.location,
      'date': DateTime.parse('${dateUTC!} ${date_Time!}:00'),
      'isComplete': false,
      'rating': null
    }, SetOptions(merge: true));
  }
}
