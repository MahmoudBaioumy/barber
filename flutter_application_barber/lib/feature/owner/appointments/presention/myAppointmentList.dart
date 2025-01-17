import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/no_scheduled.dart';
import 'package:intl/intl.dart';

class OwnerAppointmentList extends StatefulWidget {
  const OwnerAppointmentList({super.key});

  @override
  _OwnerAppointmentListState createState() => _OwnerAppointmentListState();
}

class _OwnerAppointmentListState extends State<OwnerAppointmentList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future<void> completeAppointment(
    String docID,
  ) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('all')
        .doc(docID)
        .delete();
    // .set({'isComplete': true}, SetOptions(merge: true));
  }

  String _dateFormatter(String timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
    return formattedDate;
  }

  String _timeFormatter(String timestamp) {
    String formattedTime =
        DateFormat('hh:mm').format(DateTime.parse(timestamp));
    return formattedTime;
  }

  showAlertDialog(BuildContext context, String docID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text("اتمام الحجز"),
          content: const Text("هل متاكد من اتمام هذا الحجز ؟"),
          actions: [
            TextButton(
              child: const Text("لا"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("نعم"),
              onPressed: () {
                completeAppointment(
                  docID,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _checkDiff(DateTime date) {
    var diff = DateTime.now().difference(date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String date) {
    if (_dateFormatter(DateTime.now().toString())
            .compareTo(_dateFormatter(date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .doc('appointments')
            .collection('all')
            .where('OwnerID', isEqualTo: '${user!.email}')
            .orderBy('date', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.docs.isEmpty
              ? const NoScheduledWidget()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];

                    return Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.white1color,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(-3, 0),
                                blurRadius: 15,
                                color: Colors.grey.withOpacity(.1),
                              )
                            ],
                          ),
                          child: ExpansionTile(
                            childrenPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            expandedCrossAxisAlignment: CrossAxisAlignment.end,
                            backgroundColor: AppColor.white2color,
                            collapsedBackgroundColor: AppColor.white2color,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    'اسم العميل: ${document['name']}',
                                    style: getTitelstyle(),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month_rounded,
                                          color: AppColor.bluecolor, size: 16),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _dateFormatter(document['date']
                                            .toDate()
                                            .toString()),
                                        style: getBodystyle(),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        _compareDate(document['date']
                                                .toDate()
                                                .toString())
                                            ? "اليوم"
                                            : "",
                                        style: getBodystyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later_outlined,
                                          color: AppColor.bluecolor, size: 16),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _timeFormatter(
                                          document['date'].toDate().toString(),
                                        ),
                                        style: getBodystyle(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5, right: 10, left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_rounded,
                                            color: AppColor.bluecolor,
                                            size: 16),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          document['location'],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor:
                                                  AppColor.white1color,
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            showAlertDialog(
                                                context, document.id);
                                          },
                                          child: const Text('اتمام الحجز')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
