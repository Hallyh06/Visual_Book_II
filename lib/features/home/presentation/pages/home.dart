import 'package:flutter/material.dart';
import 'package:visual_book/features/home/presentation/pages/book_screen.dart';
import 'package:visual_book/features/home/presentation/pages/menu_page.dart';
import 'package:visual_book/features/home/presentation/pages/settinng_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int currenntIndex = 0;
final tabs = [
  const MenuPage(),
  const BookScreen(),
  const SettingScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[currenntIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffDBD2C2),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: currenntIndex,
        onTap: (index) {
          setState(() {
            currenntIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.menu_book,
                color: Colors.white,
              ),
              label: 'Book'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: 'Setting')
        ],
      ),
    );
  }
}
