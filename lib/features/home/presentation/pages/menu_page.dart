import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/utils/font.dart';
import 'package:visual_book/core/navigator/router.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(90),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    MenuOption(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.activitiesPage,
                          );
                        },
                        tittle: 'Activities',
                        icon: Image.asset(
                          AppAssets.activities,
                          height: 80,
                          width: 80,
                        )),
                    MenuOption(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.mediaEditor);
                        },
                        tittle: 'Media editor',
                        icon: Image.asset(
                          AppAssets.mediaIconc,
                          height: 80,
                          width: 80,
                        )),
                    MenuOption(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.bookSetup);
                        },
                        tittle: 'Book Setup',
                        icon: Image.asset(
                          AppAssets.book,
                          height: 80,
                          width: 80,
                        )),
                    MenuOption(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.giftSetup);
                        },
                        tittle: 'Gift Setup',
                        icon: Image.asset(
                          AppAssets.gift,
                          height: 80,
                          width: 80,
                        )),
                    MenuOption(
                        onTap: () {},
                        tittle: 'Help',
                        icon: Image.asset(
                          AppAssets.helpIcon,
                          height: 60,
                          width: 60,
                        )),
                    MenuOption(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.shop);
                        },
                        tittle: 'Shop',
                        icon: Image.asset(
                          AppAssets.shop,
                          height: 80,
                          width: 80,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  const MenuOption(
      {super.key,
      required this.onTap,
      required this.tittle,
      required this.icon});
  final VoidCallback onTap;
  final String tittle;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xffDBD2C2),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const Gap(20),
            TextBody(
              tittle,
              fontSize: 12,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
