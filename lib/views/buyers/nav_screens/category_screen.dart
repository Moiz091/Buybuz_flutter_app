import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrktplace_store/views/buyers/inner_screens/all_product_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Scaffold(
      appBar: AppBar(
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
          'Categories',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Color(0xFF3366FF)),
            );
          }

          return Container(
            height: 200,
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final categoryData = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AllProductScreen(
                            categoryData: categoryData,
                          );
                        }));
                      },
                      leading: Image.network(categoryData['image']),
                      title: Text(
                        categoryData['categoryName'],
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF3366FF),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
