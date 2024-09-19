import 'package:flutter/material.dart';
import 'package:mrktplace_store/vendor/views/screens/edit_product_Tab/published_tab.dart';
import 'package:mrktplace_store/vendor/views/screens/edit_product_Tab/unpublished_tab.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
            colors: [
              Color(0xFF3366FF),
              Color(0xFF00CCFF),
            ],
          ))),
          title: Text(
            'Manage Products',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                'Published',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Unpublished',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [
          PublishedTab(),
          UnPublishedTab(),
        ]),
      ),
    );
  }
}
