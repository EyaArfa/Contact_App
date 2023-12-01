import 'dart:io';

import 'package:callapp/pages/home.dart';
import 'package:callapp/usefull/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../widgets/customButton.dart';
import '../widgets/customTextField.dart';
import '../widgets/customTitle.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final txtEmailController = TextEditingController();
  final txtPasswordController = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  saveUser() async {
    final storage = const FlutterSecureStorage();
    await storage.write(key: 'name', value: txtEmailController.text);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 193, 221, 226),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage('assets/images/Mobile login-bro.png'),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: ClipPath(
                      clipper: CustomClipperPath(),
                      child: Container(
                        padding: const EdgeInsets.all(35),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomTitle('Authicate', bottom: 20, top: 40),
                                CustomTextField(
                                  'Enter your email',
                                  controller: txtEmailController,
                                  icon: const Icon(Icons.email),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please enter your email';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                CustomTextField(
                                  'Enter password',
                                  controller: txtPasswordController,
                                  icon: const Icon(Icons.password),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please enter your password';
                                    }
                                    return null;
                                  },
                                  show: true,
                                ),
                                CustomButton(
                                  onCLick: () async {
                                    if (_formKey.currentState!.validate()) {
                                      saveUser();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()));
                                    }
                                  },
                                  text: 'Submit',
                                ),
                                CustomButton(
                                    onCLick: () {
                                      exit(0);
                                    },
                                    text: 'Quit'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final path = Path()
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..quadraticBezierTo(width * 0.9, height * 0.3, 0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
