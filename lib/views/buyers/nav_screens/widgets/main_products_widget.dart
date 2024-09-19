import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrktplace_store/views/buyers/product_details/product_detail_screen.dart';

class MainProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productssStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productssStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(
            color: Color(0xFF3366FF),
          );
        }

        return Container(
            height: 270,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(
                          productData: productData,
                        );
                      }));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(productData['imageUrl'][0]),
                              fit: BoxFit.cover,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              productData['productName'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\£' +
                                  " " +
                                  productData['productPrice']
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3366FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, _) => SizedBox(
                      width: 15,
                    ),
                itemCount: snapshot.data!.docs.length));
      },
    );
  }
}
