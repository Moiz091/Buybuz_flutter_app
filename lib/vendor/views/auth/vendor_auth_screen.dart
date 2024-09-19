import 'package:flutter/material.dart';
import 'package:mrktplace_store/controllers/auth_controller.dart';
import 'package:mrktplace_store/utils/show_snackBar.dart';
import 'package:mrktplace_store/vendor/views/auth/vendor_registration.dart';
import 'package:mrktplace_store/vendor/views/screens/main_vendor_screen.dart';

class VendorAuthScreen extends StatefulWidget {
  @override
  State<VendorAuthScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<VendorAuthScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;

  late String password;

  bool _isLoading = false;

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      String res = await _authController.loginUsers(email, password);

      if (res == 'success') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MainVendorScreen();
        }));
      } else {
        showSnackBar(context, res);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnackBar(context, 'Pleae fields must not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Vendors Account',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3366FF)),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: ((value) {
                    email = value;
                  }),
                  decoration: InputDecoration(
                    labelText: 'Enter E-mail Address',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: ((value) {
                    password = value;
                  }),
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _loginUsers();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF3366FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Need An Account'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return VendorRegistrationScreen();
                      }));
                    },
                    child: Text('Register'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
