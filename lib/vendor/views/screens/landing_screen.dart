import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrktplace_store/vendor/models/vendor_user_models.dart';
import 'package:mrktplace_store/vendor/views/auth/vendor_registration.dart';
import 'package:mrktplace_store/vendor/views/screens/main_vendor_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _vendorsStream =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (!snapshot.data!.exists) {
          return VendorRegistrationScreen();
        }

        VendorUserModel vendorUserModel = VendorUserModel.fromJson(
            snapshot.data!.data()! as Map<String, dynamic>);

        if (vendorUserModel.approved == true) {
          return MainVendorScreen();
        }
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                vendorUserModel.storeImage.toString(),
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              vendorUserModel.bussinessName.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Your Application has been sent to shop admin\n Admin will be get back to you soon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: Text('Sign Out'))
          ],
        ));
      },
    ));
  }
}
