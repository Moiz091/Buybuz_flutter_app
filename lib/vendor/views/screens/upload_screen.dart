import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mrktplace_store/provider/product_provider.dart';
import 'package:mrktplace_store/vendor/views/screens/main_vendor_screen.dart';
import 'package:mrktplace_store/vendor/views/screens/upload_tap_screens/attributes_screen.dart';
import 'package:mrktplace_store/vendor/views/screens/upload_tap_screens/general_screen.dart';
import 'package:mrktplace_store/vendor/views/screens/upload_tap_screens/images_screen.dart';
import 'package:mrktplace_store/vendor/views/screens/upload_tap_screens/shipping_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 25,
            elevation: 0,
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
              colors: [
                Color(0xFF3366FF),
                Color(0xFF00CCFF),
              ],
            ))),
            bottom: TabBar(
                unselectedLabelColor: const Color.fromARGB(157, 255, 255, 255),
                labelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text('General'),
                  ),
                  Tab(
                    child: Text('Shipping'),
                  ),
                  Tab(
                    child: Text('Attribute'),
                  ),
                  Tab(
                    child: Text('Images'),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            GeneralScreen(),
            ShippingScreeen(),
            AttributesTabScreen(),
            ImagesTabScreen(),
          ]),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3366FF)),
                onPressed: () async {
                  EasyLoading.show(status: 'Please Wait...');
                  if (_formKey.currentState!.validate()) {
                    final productId = Uuid().v4();
                    await _firestore.collection('products').doc(productId).set({
                      'productId': productId,
                      'productName':
                          _productProvider.productData['productName'],
                      'productPrice':
                          _productProvider.productData['productPrice'],
                      'quantity': _productProvider.productData['quantity'],
                      'category': _productProvider.productData['category'],
                      'description':
                          _productProvider.productData['description'],
                      'imageUrl': _productProvider.productData['imageUrlList'],
                      'scheduleDate':
                          _productProvider.productData['scheduleDate'],
                      'chargeShipping':
                          _productProvider.productData['chargeShipping'],
                      'shippingCharge':
                          _productProvider.productData['shippingCharge'],
                      'brandName': _productProvider.productData['brandName'],
                      'sizeList': _productProvider.productData['sizeList'],
                    }).whenComplete(() {
                      _formKey.currentState!.reset();
                      EasyLoading.dismiss();
                      _productProvider.clearData();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MainVendorScreen();
                      }));
                    });
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }
}
