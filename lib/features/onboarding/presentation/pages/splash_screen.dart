import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_book/core/constant/app_assets.dart';
import 'package:visual_book/core/navigator/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getLoogedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool visited = preferences.getBool('LoggedIn') ?? false;
    return visited;
  }

  checkVisitStatus() async {
    bool loggedIn = await getLoogedIn();
    Future.delayed(const Duration(seconds: 3), () {
      if (loggedIn == true) {
        Navigator.pushNamed(context, RouteName.homeScreen);
      } else {
        Navigator.pushNamed(context, RouteName.emailScreen);
      }
    });
  }

  @override
  void initState() {
    checkVisitStatus();
    super.initState();
    /* Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(
        context,
        RouteName.emailScreen,
      );
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: Center(
          child: Image.asset(
            AppAssets.vsLogo,
            height: 200,
            width: 200,
          ),
        ));
  }
}
