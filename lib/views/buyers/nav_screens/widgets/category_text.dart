import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrktplace_store/views/buyers/nav_screens/widgets/home_prodcut.dart';
import 'package:mrktplace_store/views/buyers/nav_screens/widgets/main_products_widget.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading Categories");
              }

              return Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final categoryData = snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ActionChip(
                                    backgroundColor: Color(0xFF3366FF),
                                    onPressed: () {
                                      setState(() {
                                        _selectedCategory =
                                            categoryData['categoryName'];
                                      });
                                    },
                                    label: Center(
                                      child: Text(
                                        categoryData['categoryName'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )),
                              );
                            })),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              );
            },
          ),
          if (_selectedCategory == null) MainProductsWidget(),
          if (_selectedCategory != null)
            HomeProdcutWidget(categoryName: _selectedCategory!),
        ],
      ),
    );
  }
}
