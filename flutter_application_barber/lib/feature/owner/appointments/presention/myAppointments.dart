import 'package:flutter/material.dart';
import 'package:flutter_application_barber/feature/owner/appointments/presention/myAppointmentList.dart';


class OwnerAppointments extends StatefulWidget {
  const OwnerAppointments({super.key});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<OwnerAppointments> {
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
        child: OwnerAppointmentList(),
      ),
    );
  }
}