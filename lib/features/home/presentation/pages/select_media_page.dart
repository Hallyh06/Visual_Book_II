import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_book/core/utils/busy_button.dart';

import '../../../../core/constant/app_assets.dart';

class SelectMediaPage extends StatefulWidget {
  const SelectMediaPage({super.key});

  @override
  State<SelectMediaPage> createState() => _SelectMediaPageState();
}

class _SelectMediaPageState extends State<SelectMediaPage> {
  File? image;

  @override
  Widget build(BuildContext context) {
    pickImageFromGallery() async {
      var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        setState(() {
          image = imageFile;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageEditor(
                savePath: '',
                image: image, // <-- Uint8List of image
                appBarColor: Colors.blue,
              ),
            ),
          );
        });
        print(pickedFile.path);
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
      ),
      body: Column(
        children: [
          Align(
            child: Image.asset(
              AppAssets.vsLogo,
              height: 80,
              width: 80,
            ),
          ),
          Expanded(
              child: image == null
                  ? const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    )
                  : Image.file(
                      image!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: BusyButton(
              ttitle: image == null ? 'Select Image' : 'Upload Image',
              onTap: () {
                pickImageFromGallery();
              },
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
