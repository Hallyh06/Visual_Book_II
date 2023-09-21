import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/core/utils/busy_button.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/features/home/presentation/pages/edit_gift.dart';

import '../../../../core/constant/app_assets.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users_gift')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('gifts')
                .snapshots(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  Align(
                    child: Image.asset(
                      AppAssets.vsLogo,
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Expanded(
                    child: Column(
                        children: List.generate(snapshot.data?.docs.length ?? 0,
                            (index) {
                      final books = snapshot.data?.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.editGift,
                                arguments: EditGiftArguement(
                                    giftName: books?['name'] ?? '',
                                    number: books?['visualCode'] ?? ''));
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff000000)
                                        .withOpacity(0.4),
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppAssets.gift,
                                    height: 30,
                                    width: 30,
                                  ),
                                  const Gap(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextSemiBold(
                                        books?['name'] ?? '',
                                        fontSize: 15,
                                      ),
                                      TextBody(
                                        books?['visualCode'] ?? '',
                                        fontSize: 9,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: BusyButton(
                      ttitle: 'Add Book',
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.giftSetup);
                      },
                    ),
                  ),
                  const Gap(20),
                ],
              );
            }),
      ),
    );
  }
}
