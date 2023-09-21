import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/features/home/presentation/pages/upload_file_page.dart';

import '../../../../core/utils/busy_button.dart';

class CreateGift extends StatefulWidget {
  const CreateGift({
    super.key,
    required this.params,
  });
  final CreateGiftParams params;
  @override
  State<CreateGift> createState() => _CreateGiftState();
}

class _CreateGiftState extends State<CreateGift> {
  bool family = false;
  bool giftMessage = false;
  bool addVideo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Gap(40),
            TextBold(
              'Create The Perfect Gift And Share Memorable Moments',
              fontSize: 20,
              color: Colors.black,
            ),
            const Gap(30),
            GestureDetector(
              onTap: () {
                setState(() {
                  giftMessage = true;
                  family = false;
                  addVideo = false;
                });
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 2,
                      color:
                          giftMessage ? const Color(0xffDBD2C2) : Colors.grey,
                    )),
                child: Center(
                  child: TextSemiBold(
                    'Gift Message',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Gap(20),
            GestureDetector(
              onTap: () {
                setState(() {
                  giftMessage = false;
                  family = true;
                  addVideo = false;
                });
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 2,
                      color: family ? const Color(0xffDBD2C2) : Colors.grey,
                    )),
                child: Center(
                  child: TextSemiBold(
                    'Invite Family And Friend',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Gap(20),
            GestureDetector(
              onTap: () {
                setState(() {
                  giftMessage = false;
                  family = false;
                  addVideo = true;
                });
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 2,
                      color: addVideo ? const Color(0xffDBD2C2) : Colors.grey,
                    )),
                child: Center(
                  child: TextSemiBold(
                    'Add Videos And Photos',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Gap(40),
            BusyButton(
              ttitle: 'Next',
              onTap: () {
                addVideo
                    ? Navigator.pushNamed(
                        context,
                        RouteName.uploadFilePage,
                        arguments: UploadArguement(
                          giftType: 'Media',
                          visualCode: widget.params.visualCode,
                          name: widget.params.name,
                        ),
                      )
                    : null;
              },
            ),
          ],
        ),
      )),
    );
  }
}

class CreateGiftParams {
  CreateGiftParams({
    required this.name,
    required this.visualCode,
  });
  final String name;
  final String visualCode;
}
