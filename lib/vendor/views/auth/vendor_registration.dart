import 'dart:typed_data';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrktplace_store/vendor/controllers/vendor_register_controller.dart';
import 'package:mrktplace_store/vendor/views/auth/vendor_auth_screen.dart';

class VendorRegistrationScreen extends StatefulWidget {
  VendorRegistrationScreen({super.key});

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final VendorController _vendorController = VendorController();
  late String bussinessName;
  late String email;
  late String phoneNumber;
  late String taxNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  String? _taxStatus;

  List<String> _taxOptions = ['YES', 'NO'];

  _saveVendorDetail() async {
    EasyLoading.show(status: 'PLease Wait');
    if (_formkey.currentState!.validate()) {
      await _vendorController
          .registerVendor(bussinessName, email, phoneNumber, countryValue,
              stateValue, cityValue, _taxStatus!, taxNumber, _image)
          .whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formkey.currentState!.reset();

          _image = null;
        });
      });
    } else {
      print('Bad');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 150,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.black,
                  ])),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                10,
                              )),
                          child: _image != null
                              ? Image.memory(_image!)
                              : IconButton(
                                  onPressed: () {
                                    selectGalleryImage();
                                  },
                                  icon: Icon(CupertinoIcons.photo)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      bussinessName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Business Name must not be Empty.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Business Name'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please E-Mail Address must not be Empty.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'E-mail Address'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Phone Number must not be Empty.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: ' Phone Number'),
                  ),
                  SelectState(
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value;
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        cityValue = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax Registtered?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: 120,
                          child: DropdownButtonFormField(
                              hint: Text('Select'),
                              items: _taxOptions.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _taxStatus = value;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                  if (_taxStatus == 'YES')
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: (TextFormField(
                        onChanged: (value) {
                          taxNumber = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Tax Number must not be Empty.';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(labelText: 'Tax Number'),
                      )),
                    ),
                  InkWell(
                    onTap: () {
                      _saveVendorDetail();
                    },
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already Have An Account'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return VendorAuthScreen();
                          }));
                        },
                        child: Text('Login'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
