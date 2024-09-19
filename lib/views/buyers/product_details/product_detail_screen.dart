import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrktplace_store/provider/cart_provider.dart';
import 'package:mrktplace_store/utils/show_snackBar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  int _imageIndex = 0;
  String? _selectedSize;
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: PhotoView(
                    imageProvider: NetworkImage(
                      widget.productData['imageUrl'][_imageIndex],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData['imageUrl'].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color(0xFF3366FF),
                                )),
                                height: 60,
                                width: 60,
                                child: Image.network(
                                    widget.productData['imageUrl'][index]),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\£' +
                    ' ' +
                    widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3366FF),
                ),
              ),
            ),
            Text(
              widget.productData['productName'],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Description',
                    style: TextStyle(color: Color(0xFF3366FF)),
                  ),
                  Text(
                    '',
                    style: TextStyle(color: Color(0xFF3366FF)),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['description'],
                    style: TextStyle(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 83, 83, 83),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Available Size',
                style: TextStyle(color: Color(0xFF3366FF)),
              ),
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: _selectedSize ==
                                    widget.productData['sizeList'][index]
                                ? Color(0xFF3366FF)
                                : null,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedSize =
                                      widget.productData['sizeList'][index];
                                });

                                print(_selectedSize);
                              },
                              child: Text(
                                widget.productData['sizeList'][index],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Product Will be Shipping On',
                    style: TextStyle(
                      color: Color(0xFF3366FF),
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    formatedDate(
                      widget.productData['scheduleDate'].toDate(),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.getCartItem
                  .containsKey(widget.productData['productId'])
              ? null
              : () {
                  if (_selectedSize == null) {
                    return showSnackBar(context, 'Please Select A Size');
                  } else {
                    _cartProvider.addProductToCart(
                        widget.productData['productName'],
                        widget.productData['productId'],
                        widget.productData['imageUrl'],
                        1,
                        widget.productData['quantity'],
                        widget.productData['productPrice'],
                        _selectedSize!,
                        widget.productData['scheduleDate']);

                    return showSnackBar(context,
                        'You Added ${widget.productData['productName']} To Your Cart');
                  }
                },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _cartProvider.getCartItem
                      .containsKey(widget.productData['productId'])
                  ? Colors.grey
                  : Color(0xFF3366FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _cartProvider.getCartItem
                          .containsKey(widget.productData['productId'])
                      ? Text(
                          'IN CART',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 5,
                          ),
                        )
                      : Text(
                          'ADD TO CART',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 5,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
