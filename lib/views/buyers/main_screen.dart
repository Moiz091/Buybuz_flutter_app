import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrktplace_store/views/buyers/nav_screens/store_screen.dart';
import 'nav_screens/cart_screen.dart';
import 'nav_screens/category_screen.dart';
import 'nav_screens/home_screen.dart';
import 'nav_screens/account_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainScreen> {
  int _pageindex = 0;
  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _pageindex,
          onTap: (value) {
            setState(() {
              _pageindex = value;
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Color(0xFF3366FF),
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'HOME'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.line_horizontal_3),
                label: 'CATEGORIES'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar), label: 'SHOP'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: 'CART'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'ACCOUNT'),
          ]),
      body: _pages[_pageindex],
    );
  }
}
