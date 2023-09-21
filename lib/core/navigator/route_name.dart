// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:visual_book/core/navigator/router.dart';
import 'package:visual_book/features/auth/presentation/pages/email_screen.dart';
import 'package:visual_book/features/auth/presentation/pages/forgot_password.dart';
import 'package:visual_book/features/auth/presentation/pages/login.dart';
import 'package:visual_book/features/auth/presentation/pages/sign_up.dart';
import 'package:visual_book/features/home/presentation/pages/activities_page.dart';
import 'package:visual_book/features/home/presentation/pages/book_setup.dart';
import 'package:visual_book/features/home/presentation/pages/creat_gift.dart';
import 'package:visual_book/features/home/presentation/pages/edit_gift.dart';
import 'package:visual_book/features/home/presentation/pages/generate_visual_code.dart';
import 'package:visual_book/features/home/presentation/pages/gift_setup.dart';
import 'package:visual_book/features/home/presentation/pages/gift_virtual_code.dart';
import 'package:visual_book/features/home/presentation/pages/home.dart';
import 'package:visual_book/features/home/presentation/pages/qr_scanner_page.dart';
import 'package:visual_book/features/home/presentation/pages/select_media_page.dart';
import 'package:visual_book/features/home/presentation/pages/shop_view.dart';
import 'package:visual_book/features/home/presentation/pages/upload_file_page.dart';
import 'package:visual_book/features/home/presentation/pages/virtual_book_for.dart';
import 'package:visual_book/features/onboarding/presentation/pages/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.splashScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SplashScreen(),
      );
    case RouteName.loginScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginScreen(
          params: settings.arguments as LoginArguement,
        ),
      );
    case RouteName.signUp:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpScreen(
          params: settings.arguments as LoginArguement,
        ),
      );
    case RouteName.emailScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const EmailScreen(),
      );
    case RouteName.homeScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const HomeScreen(),
      );
    case RouteName.bookSetup:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const BookSetup(),
      );
    case RouteName.qrScanner:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const QRScanner(),
      );
    case RouteName.virtualBookFor:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const VirtualBookFor(),
      );
    case RouteName.creatGift:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateGift(
          params: settings.arguments as CreateGiftParams,
        ),
      );
    case RouteName.activitiesPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const ActivitiesPage(),
      );
    case RouteName.giftSetup:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const GiftSetup(),
      );
    case RouteName.mediaEditor:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SelectMediaPage(),
      );
    case RouteName.shop:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const ShopViewPage(),
      );
    case RouteName.forgotPassword:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const ForgotPassword(),
      );
    case RouteName.generateVirtualCode:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const GenerateVirtualCode(),
      );
    case RouteName.giftVirtualCode:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: GiftVirtualCode(
          params: settings.arguments as GiftArguement,
        ),
      );
    case RouteName.uploadFilePage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: UploadFilePage(
          params: settings.arguments as UploadArguement,
        ),
      );
    case RouteName.editGift:
      return _getPageRoute(
          routeName: settings.name,
          viewToShow: EditGift(
            params: settings.arguments as EditGiftArguement,
          ));
    default:
      return MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute<void>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow!,
  );
}
