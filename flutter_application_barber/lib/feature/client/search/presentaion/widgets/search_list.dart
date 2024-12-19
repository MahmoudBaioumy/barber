import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/barbers_Card.dart';
import 'package:flutter_svg/svg.dart';

class SearchList extends StatefulWidget {
  final String searchKey;
  const SearchList({super.key, required this.searchKey});

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('doctor')
          .orderBy('name')
          .startAt([widget.searchKey]).endAt(
              ['${widget.searchKey}\uf8ff']).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data?.size == 0
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/no-search.svg',
                        width: 250,
                      ),
                      Text(
                        'لا يوجد خلاق بهذا الاسم',
                        style: getBodystyle(),
                      ),
                    ],
                  ),
                ),
              )
            : Scrollbar(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doctor = snapshot.data!.docs[index];
                    if (doctor['name'] == null ||
                        doctor['image'] == null ||
                        doctor['specialization'] == null ||
                        doctor['rating'] == null) {
                      return const SizedBox();
                    }
                    return BarbersCard(
                        name: doctor['name'],
                        image: doctor['image'],
                        specialization: doctor['specialization'],
                        rating: doctor['rating'],
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ClientProfile(
                          //        doctor:  DoctorModel(
                          //           id: doctor.id,
                          //           name: doctor['name'],
                          //           image: doctor['image'],
                          //           specialization: doctor['specialization'],
                          //           rating: doctor['rating'],
                          //           email: doctor['email'],
                          //           phone1: doctor['phone1'],
                          //           phone2: doctor['phone2'],
                          //           bio: doctor['bio'],
                          //           openHour: doctor['openHour'],
                          //           closeHour: doctor['closeHour'],
                          //           address: doctor['address'],
                          //         ),
                          //     ),
                          //   ),
                          // );
                        });
                  },
                ),
              );
      },
    );
  }
}
