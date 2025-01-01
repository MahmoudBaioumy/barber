import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/core/widgets/custom_buttons.dart';
import 'package:flutter_application_barber/core/widgets/tile_widget.dart';
import 'package:flutter_application_barber/feature/client/profile/pages/userSettings.dart';
import 'package:flutter_application_barber/feature/client/profile/widget/appointments_list.dart';
import 'package:image_picker/image_picker.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({super.key});

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

String? _imagePath;
File? file;
String? profileUrl;

String? userId;
Future<void> _getUser() async {
  userId = FirebaseAuth.instance.currentUser?.uid;
}

class _ClientProfileState extends State<ClientProfile> {
  //*******************/////uploadImageToFireStore/////////////**************************** */
  uploadImageToFireStore(File image, String imageName) async {
    Reference ref =
        FirebaseStorage.instanceFor(bucket: 'gs://se7ety-f02b3.appspot.com')
            .ref()
            .child('Client/${FirebaseAuth.instance.currentUser!.uid}');
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(image, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  ///////////********************getuser to push his image********//////////////////////////////////////
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
    FirebaseFirestore.instance.collection('Client').doc(userId).set({
      'image': profileUrl,
    }, SetOptions(merge: true));
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
          elevation: 0,
          title: Text(
            'الحساب الشخصي',
            style: getTitelstyle(color: AppColor.white1color, fontSize: 20),
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
                        builder: (contex) => const UserSettings()));
              },
            ),
          ],
        ),
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('client')
                  .doc(userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColor.bluecolor,
                    ),
                  );
                }
                var userData = snapshot.data;
                return Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
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
                                        backgroundImage: (userData?['iamge'] !=
                                                '')
                                            ? NetworkImage(userData?['iamge'])
                                            : (_imagePath != null)
                                                ? FileImage(File(_imagePath!))
                                                    as ImageProvider
                                                : const AssetImage(
                                                    'assets/pp.png'),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await _pickImage();
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Icon(
                                          Icons.camera_alt_rounded,
                                          size: 20,
                                          color: AppColor.bluecolor,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${userData!['name']}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: getTitelstyle(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      (userData['city'] == '')
                                          ? CustomButton(
                                              text: 'تعديل الحساب',
                                              height: 40,
                                              onPressed: () {},
                                              background: AppColor.bluecolor,
                                            )
                                          : Text(
                                              userData['city'],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: getBodystyle(),
                                            ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              "نبذه تعريفيه",
                              style: getBodystyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              userData['bio'] == ''
                                  ? 'لم تضاف'
                                  : userData['bio'],
                              style: getsmallstyle(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "معلومات التواصل",
                              style: getBodystyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.white2color,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TileWidget(
                                      text: userData['email'] ?? 'لم تضاف',
                                      icon: Icons.email),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TileWidget(
                                      text: userData['phone'] == ''
                                          ? 'لم تضاف'
                                          : userData['phone'],
                                      icon: Icons.call),
                                ],
                              ),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "حجوزاتي",
                              style: getBodystyle(fontWeight: FontWeight.w600),
                            ),
                            const MyAppointmentsHistory()
                          ]),
                    ));
              }),
        ));
  }
}
