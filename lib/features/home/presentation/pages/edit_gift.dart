// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/utils/app_loader.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/firebase_api.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/features/home/presentation/widgets/select_img_options.dart';

import '../../../../core/navigator/router.dart';

class EditGift extends StatefulWidget {
  const EditGift({
    super.key,
    required this.params,
  });
  final EditGiftArguement params;
  @override
  State<EditGift> createState() => _EditGiftState();
}

class _EditGiftState extends State<EditGift> {
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
      storeGift.collection('Gift').doc(widget.params.number).update({
        'mediaUrl': urlDownload,
        'caption': caption,
        'type': type,
      });
      storeGift
          .collection('users_gift')
          .doc(auth.currentUser!.uid)
          .collection('gifts')
          .doc()
          .update({
        'mediaUrl': urlDownload,
        'caption': caption,
        'type': type,
      });
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.homeScreen, (route) => false);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
          child: Column(
        children: [
          Align(
            child: Image.asset(
              AppAssets.vsLogo,
              height: 80,
              width: 80,
            ),
          ),
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
                  ttitle: video == null ? 'Select Video' : 'Upload Video',
                  onTap: video == null
                      ? () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SelectImageOtions(onTapCamera: () {
                                  Navigator.pop(context);
                                  getVideo(imageSource: ImageSource.camera);
                                }, onTapGallery: () {
                                  Navigator.pop(context);
                                  getVideo(imageSource: ImageSource.gallery);
                                });
                              });
                        }
                      : () async {
                          await uploadFile(
                              file: video!,
                              type: 'Video',
                              caption: captionController.text);
                        },
                ),
                const Gap(20),
                BusyButton(
                  ttitle: image == null ? 'Select Photo' : 'Upload Photo',
                  onTap: image == null
                      ? () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SelectImageOtions(
                                  onTapCamera: () {
                                    Navigator.pop(context);
                                    pickPhotos(imageSource: ImageSource.camera);
                                  },
                                  onTapGallery: () {
                                    Navigator.pop(context);
                                    pickPhotos(
                                        imageSource: ImageSource.gallery);
                                  },
                                );
                              });
                        }
                      : () async {
                          await uploadFile(
                            file: image!,
                            type: 'Photo',
                            caption: captionController.text,
                          );
                        },
                ),
                const Gap(24),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class EditGiftArguement {
  EditGiftArguement({
    required this.giftName,
    required this.number,
  });
  final String giftName;
  final String number;
}
