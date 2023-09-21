import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/core/utils/flushbar_notification.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/features/home/presentation/pages/gift_virtual_code.dart';

import '../../../../core/constant/app_assets.dart';

class VirtualBookFor extends StatefulWidget {
  const VirtualBookFor({super.key});

  @override
  State<VirtualBookFor> createState() => _VirtualBookForState();
}

class _VirtualBookForState extends State<VirtualBookFor> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                child: Image.asset(
                  AppAssets.vsLogo,
                  height: 80,
                  width: 80,
                ),
              ),
              const Gap(40),
              TextBold(
                'Who are you preparing the virtual book for?',
                fontSize: 20,
                color: Colors.black,
              ),
              const Gap(20),
              TextSemiBold(
                'Set the receipient name or add a title. They can rename the book later.',
                maxLines: 5,
                fontSize: 15,
                color: Colors.black,
              ),
              const Gap(40),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Color(0xffDBD2C2),
                      ),
                      const Gap(10),
                      Expanded(
                        child: TextFormField(
                          controller: nameController,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(40),
              GestureDetector(
                onTap: () {
                  if (nameController.text.isEmpty) {
                    return FlushbarNotification.showErrorMessage(context,
                        message: 'Name cannot be empty');
                  } else {
                    Navigator.pushNamed(
                      context,
                      RouteName.giftVirtualCode,
                      arguments: GiftArguement(
                        name: nameController.text,
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 3,
                      color: const Color(0xffDBD2C2),
                    ),
                  ),
                  child: Center(
                    child: TextSemiBold(
                      'Next',
                      fontSize: 14,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
