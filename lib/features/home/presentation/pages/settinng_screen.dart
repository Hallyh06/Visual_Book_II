// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/core/utils/font.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> _launchUrl({
    required String link,
  }) async {
    final Uri _url = Uri.parse(link);

    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $_url');
    }
  }

  String name = '';
  String email = '';
  _userProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!.uid;
    if (firebaseUser.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser)
          .get()
          .then((value) {
        name = value['name'];
        email = value['email'];

        // print(myPhone);
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future<void> _signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    await FirebaseAuth.instance.signOut();

    Navigator.pushNamedAndRemoveUntil(
        context, RouteName.emailScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: _userProfile(),
              builder: (context, state) {
                return Column(
                  children: [
                    Align(
                      child: Image.asset(
                        AppAssets.vsLogo,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    const Gap(10),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xffDBD2C2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            TextBody(
                              'Name:',
                              fontSize: 15,
                              color: const Color(0xff000000),
                            ),
                            const Gap(10),
                            TextSemiBold(
                              name,
                              fontSize: 15,
                              color: const Color(0xff000000),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xffDBD2C2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            TextBody(
                              'Email:',
                              fontSize: 15,
                              color: const Color(0xff000000),
                            ),
                            const Gap(10),
                            TextSemiBold(
                              email,
                              fontSize: 15,
                              color: const Color(0xff000000),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: const Color(0xffDBD2C2),
                          )),
                      child: Center(
                        child: TextBody(
                          'Change Language',
                          fontSize: 10,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.forgotPassword);
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: const Color(0xffDBD2C2),
                            )),
                        child: Center(
                          child: TextBody(
                            'Change Password',
                            fontSize: 10,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: const Color(0xffDBD2C2),
                          )),
                      child: Center(
                        child: TextBody(
                          'Wipe and Unpair Devices',
                          fontSize: 10,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    const Gap(40),
                    TextButton(
                      onPressed: _signOut,
                      child: TextSemiBold(
                        'Sign Out',
                        fontSize: 15,
                        color: const Color(0xffDBD2C2),
                      ),
                    ),
                    const Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                                link:
                                    'https://www.instagram.com/thevisualbook/');
                          },
                          child: Image.asset(
                            AppAssets.instagram,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        const Gap(15),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                                link: 'https://www.tiktok.com/@thevisualbook');
                          },
                          child: Image.asset(
                            AppAssets.titok,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        const Gap(15),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(link: 'https://pin.it/7eBDrlr');
                          },
                          child: Image.asset(
                            AppAssets.pinterest,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        const Gap(15),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                                link:
                                    'https://www.youtube.com/@the.visualbook');
                          },
                          child: Image.asset(
                            AppAssets.youtube,
                            height: 50,
                            width: 50,
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
