import 'package:flutter/material.dart';
import 'package:flutter_application_barber/feature/client/appointments/myAppointmentList.dart';


class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مواعيد الحجز',
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: MyAppointmentList(),
      ),
    );
  }
}