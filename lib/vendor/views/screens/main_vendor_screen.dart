import 'package:flutter/material.dart';
import 'package:mrktplace_store/vendor/views/screens/earnings_screen.dart';
import 'package:mrktplace_store/vendor/views/screens/edit_product_screen.dart';
import 'package:mrktplace_store/vendor/views/screens/upload_screen.dart';
import 'package:mrktplace_store/vendor/views/screens/vendor_logout_screen.dart';
import 'package:mrktplace_store/vendor/views/screens/vendor_order_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    EarningsScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: ((value) {
            setState(() {
              _pageIndex = value;
            });
          }),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          selectedItemColor: Color(0xFF3366FF),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.money), label: 'EARNINGS'),
            BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'UPLOAD'),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'EDIT'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'ORDERS'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'ACCOUNT'),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
