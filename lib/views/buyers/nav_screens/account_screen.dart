import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrktplace_store/views/buyers/auth/login_screen.dart';
import 'package:mrktplace_store/views/buyers/inner_screens/order_screen.dart';
import '../inner_screens/edit_profile.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return _auth.currentUser == null
        ? SingleChildScrollView(
            child: Scaffold(
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
                  'Profile',
                  style: TextStyle(letterSpacing: 4, color: Colors.white),
                ),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Color(0xFF3366FF),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login Account TO Access Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return UserLoginScreen();
                      }));
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 200,
                      decoration: BoxDecoration(
                        color: Color(0xFF3366FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                          child: Text(
                        'LOGIN ACCOUNT',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 4,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )
        : FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
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
                      'Profile',
                      style: TextStyle(
                          letterSpacing: 4,
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 64,
                            backgroundColor: Color(0xFF3366FF),
                            backgroundImage: NetworkImage(data['profileImage']),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['fullName'],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['email'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditPRofileScreen(
                                userData: data,
                              );
                            }));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 200,
                            decoration: BoxDecoration(
                              color: Color(0xFF3366FF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                                child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('Phone'),
                        ),
                        ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text('Cart'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CustomerOrderScreen();
                            }));
                          },
                          leading: Icon(Icons.shopping_bag),
                          title: Text('Order'),
                        ),
                        ListTile(
                          onTap: () async {
                            await _auth.signOut().whenComplete(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UserLoginScreen();
                              }));
                            });
                          },
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          );
  }
}
