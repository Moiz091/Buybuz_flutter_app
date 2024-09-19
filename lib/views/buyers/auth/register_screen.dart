import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrktplace_store/controllers/auth_controller.dart';
import 'package:mrktplace_store/utils/show_snackBar.dart';
import 'package:mrktplace_store/views/buyers/auth/login_screen.dart';

class BuyerRegisterScreen extends StatefulWidget {
  const BuyerRegisterScreen({super.key});

  @override
  State<BuyerRegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<BuyerRegisterScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _signUpUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      await _authController
          .signUpUsers(email, fullName, phoneNumber, password, _image)
          .whenComplete(() {
        setState(() {
          _formkey.currentState!.reset();
          _isLoading = false;
        });
      });
      return showSnackBar(context, 'Congratulation Account has been created');
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnackBar(context, 'Please field must not be empty');
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create Customer Account'),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundColor: Color(0xFF00CCFF),
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: Color(0xFF00CCFF),
                            backgroundImage: NetworkImage(
                                'https://i.pngimg.me/thumb/f/720/c3f2c592f9.jpg'),
                          ),
                    Positioned(
                      right: 33,
                      top: 40,
                      child: IconButton(
                        onPressed: () {
                          selectGalleryImage();
                        },
                        icon: Icon(CupertinoIcons.photo),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter E-mail',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Full Name';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Phone Number';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Password';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _signUpUsers();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF3366FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Center(
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
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
                          return UserLoginScreen();
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
      ),
    );
  }
}
