import 'package:flutter/material.dart';

class Myappointments extends StatefulWidget {
  const Myappointments({super.key});

  @override
  State<Myappointments> createState() => _MyappointmentsState();
}

class _MyappointmentsState extends State<Myappointments> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('myAppointments')),
    );
  }
}
