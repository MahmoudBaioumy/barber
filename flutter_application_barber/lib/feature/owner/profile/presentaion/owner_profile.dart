import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/tile_widget.dart';
import 'package:flutter_application_barber/feature/client/search/data/onwer_model.dart';
import 'package:flutter_application_barber/feature/owner/profile/presentaion/ownerSettings.dart';
import 'package:flutter_application_barber/feature/owner/profile/widgets/con_tile.dart';
import 'package:image_picker/image_picker.dart';

class OwnerProfile extends StatefulWidget {
  final String? email;

  const OwnerProfile({
    super.key,
    this.email,
  });
  @override
  _OwnerProfileState createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userId;

  Future<void> _getUser() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  uploadImageToFireStore(File image, String imageName) async {
    Reference ref =
        FirebaseStorage.instanceFor(bucket: 'gs://se7ety-f02b3.appspot.com')
            .ref()
            .child('Owner/${FirebaseAuth.instance.currentUser!.uid}');
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(image, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
    profileUrl = await uploadImageToFireStore(file!, 'doc');
    FirebaseFirestore.instance.collection('Owner').doc(userId).set({
      'image': profileUrl,
    }, SetOptions(merge: true));
  }

  late Onwer onwer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'بيانات الحلآق',
          style: getTitelstyle(
              color: AppColor.white1color,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.white1color,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.settings,
              color: AppColor.white1color,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => const Ownersettings()));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Owner')
            .where('email', isEqualTo: widget.email)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userData = snapshot.data!.docs[0];
          onwer = Onwer(
              name: userData['name'],
              imageUrl: userData['image'],
              rating: userData['rating'],
              email: userData['email'],
              startHour: userData['openHour'],
              endHour: userData['closeHour'],
              location: userData['address']);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // ------------ Header ---------------
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColor.white1color,
                          child: CircleAvatar(
                            backgroundColor: AppColor.white1color,
                            radius: 60,
                            backgroundImage: (userData['image'] != null)
                                ? NetworkImage(userData['image'])
                                    as ImageProvider
                                : const AssetImage('assets/pp.png'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                              // color: AppColors.color1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "أ. ${userData['name']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getTitelstyle(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                userData['rating'].toString(),
                                style: getBodystyle(),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.star_rounded,
                                size: 20,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              IconTile(
                                onTap: () {},
                                backColor: AppColor.white2color,
                                imgAssetPath: Icons.phone,
                                num: '1',
                              ),
                              if (userData['phone2'] != null)
                                IconTile(
                                  onTap: () {},
                                  backColor: AppColor.white2color,
                                  imgAssetPath: Icons.phone,
                                  num: '2',
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                //////////******************************************************/body***************************************///////////////////////////////
                Text(
                  "نبذه تعريفية",
                  style: getBodystyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userData['bio'],
                  style: getsmallstyle(color: AppColor.greycolor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.white2color,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileWidget(
                          text:
                              '${userData['openHour']} - ${userData['closeHour']}',
                          icon: Icons.watch_later_outlined),
                      const SizedBox(
                        height: 15,
                      ),
                      TileWidget(
                          text: userData['address'],
                          icon: Icons.location_on_rounded),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "معلومات الاتصال",
                  style: getBodystyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.white2color,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileWidget(text: userData['email'], icon: Icons.email),
                      const SizedBox(
                        height: 15,
                      ),
                      TileWidget(text: userData['phone1'], icon: Icons.call),
                      const SizedBox(
                        height: 15,
                      ),
                      if (userData['phone2'] != null)
                        TileWidget(text: userData['phone2'], icon: Icons.call),
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      ),
    );
  }
}
