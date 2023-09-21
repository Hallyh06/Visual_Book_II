// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/core/utils/app_loader.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/firebase_api.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/features/home/presentation/widgets/select_img_options.dart';

class UploadFilePage extends StatefulWidget {
  const UploadFilePage({
    super.key,
    required this.params,
  });
  final UploadArguement params;
  @override
  State<UploadFilePage> createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  TextEditingController captionController = TextEditingController();
  File? image;
  File? video;
  String videoPath = '';
  String giverName = '';

  UploadTask? task;
  pickPhotos({required ImageSource imageSource}) async {
    var pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        image = imageFile;
        video = null;
      });
      print(pickedFile.path);
    }
  }

  Future getVideo({required ImageSource imageSource}) async {
    final pickedFile = await ImagePicker().pickVideo(
        source: imageSource,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10));
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          video = File(pickedFile!.path);
          image = null;
          videoPath = pickedFile.path;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future uploadFile({
    required File file,
    required String type,
    required String caption,
    required String giverName,
  }) async {
    unawaited(AppLoadingPopUp().show(context));
    try {
      FirebaseFirestore storeGift = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      if (file == null) return;

      final fileName = file.path;
      final destination = 'files/$fileName';

      task = FirebaseApi.uploadFile(context, destination, file!);
      setState(() {});

      if (task == null) return;

      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      print('Download-Link: $urlDownload');
      storeGift.collection('Gift').doc(widget.params.visualCode).set({
        'name': widget.params.name,
        'giftType': type,
        'visualCode': widget.params.visualCode,
        'mediaUrl': urlDownload,
        'caption': caption,
        'giverName': giverName,
      });
      storeGift
          .collection('users_gift')
          .doc(auth.currentUser!.uid)
          .collection('gifts')
          .doc()
          .set({
        'name': widget.params.name,
        'giftType': type,
        'visualCode': widget.params.visualCode,
        'mediaUrl': urlDownload,
        'caption': caption,
        'giverName': giverName,
      });
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.homeScreen, (route) => false);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  _userProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!.uid;
    if (firebaseUser.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser)
          .get()
          .then((value) {
        giverName = value['name'];

        // print(myPhone);
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _userProfile(),
            builder: (context, state) {
              return Column(
                children: [
                  Column(
                    children: [
                      image != null
                          ? Image.file(
                              image!,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : video != null
                              ? Align(
                                  child: Center(
                                    child: TextSemiBold(
                                      videoPath,
                                      fontSize: 15,
                                      color: const Color(0xffDBD2C2),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                      const Gap(10),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xffDBD2C2),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: captionController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write Caption for media',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 12,
                                  )),
                            ),
                          ),
                        ),
                        const Gap(20),
                        BusyButton(
                          ttitle:
                              video == null ? 'Select Video' : 'Upload Video',
                          onTap: video == null
                              ? () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SelectImageOtions(
                                            onTapCamera: () {
                                          Navigator.pop(context);
                                          getVideo(
                                              imageSource: ImageSource.camera);
                                        }, onTapGallery: () {
                                          Navigator.pop(context);
                                          getVideo(
                                              imageSource: ImageSource.gallery);
                                        });
                                      });
                                }
                              : () async {
                                  await uploadFile(
                                      file: video!,
                                      type: 'Video',
                                      giverName: giverName,
                                      caption: captionController.text);
                                },
                        ),
                        const Gap(20),
                        BusyButton(
                          ttitle:
                              image == null ? 'Select Photo' : 'Upload Photo',
                          onTap: image == null
                              ? () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SelectImageOtions(
                                          onTapCamera: () {
                                            Navigator.pop(context);
                                            pickPhotos(
                                                imageSource:
                                                    ImageSource.camera);
                                          },
                                          onTapGallery: () {
                                            Navigator.pop(context);
                                            pickPhotos(
                                                imageSource:
                                                    ImageSource.gallery);
                                          },
                                        );
                                      });
                                }
                              : () async {
                                  await uploadFile(
                                    file: image!,
                                    type: 'Photo',
                                    caption: captionController.text,
                                    giverName: giverName,
                                  );
                                },
                        ),
                        const Gap(24),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class UploadArguement {
  UploadArguement({
    required this.giftType,
    required this.visualCode,
    required this.name,
  });
  final String giftType;
  final String visualCode;
  final String name;
}
