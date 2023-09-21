import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/utils/font.dart';

class SelectImageOtions extends StatelessWidget {
  const SelectImageOtions({
    super.key,
    required this.onTapCamera,
    required this.onTapGallery,
  });
  final VoidCallback onTapCamera;
  final VoidCallback onTapGallery;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffFFFFFF),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTapCamera,
                child: Row(
                  children: [
                    const Icon(
                      Icons.camera,
                      size: 40,
                      color: Color(0xffDBD2C2),
                    ),
                    const Gap(20),
                    TextSemiBold('Select from camera')
                  ],
                ),
              ),
              const Gap(20),
              GestureDetector(
                onTap: onTapGallery,
                child: Row(
                  children: [
                    const Icon(
                      Icons.photo_album,
                      size: 40,
                      color: Color(0xffDBD2C2),
                    ),
                    const Gap(20),
                    TextSemiBold('Select from gallery')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
