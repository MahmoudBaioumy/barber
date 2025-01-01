import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/widgets/barbers_Card.dart';
import 'package:flutter_application_barber/feature/owner/profile/presentaion/owner_profile.dart';


// collection why?

// orderBy الترتيب
// Where المقارنه والتحديد
// StartAt & EndAt السيرش

// uid

class TopRatedList extends StatefulWidget {
  const TopRatedList({super.key});

  @override
  _TopRatedListState createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Owner')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return  Center(
              child: CircularProgressIndicator(
                color: AppColor.bluecolor,
              ),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var Owner =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                if (Owner['name'] == null ||
                    Owner['image'] == null 
                  
                    ) {
                  return const SizedBox();
                }
                return BarbersCard(
                    name: Owner['name'],
                    image: Owner['image'],
                 
                    rating: Owner['rating'],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OwnerProfile(
                            email: Owner['email'],
                          ),
                        ),
                      );
                    });
              },
            );
          }
        },
      ),
    );
  }
}