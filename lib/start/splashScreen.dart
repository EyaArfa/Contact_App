import 'package:callapp/pages/auth.dart';
import 'package:callapp/pages/home.dart';
import 'package:callapp/services/sqlite_serice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isLogged = false;
  @override
  void initState() {
    super.initState();
    checkLoggedIn();

    _controller = AnimationController(
      duration: const Duration(seconds: (5)),
      vsync: this,
    );
  }

  checkLoggedIn() async {
    final storage = FlutterSecureStorage();
    String? name = await storage.read(key: 'name');
    print(name);
    if (name != null) {
      setState(() {
        isLogged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Center(
          child: Lottie.asset('assets/lottie/splash_screen.json',
              animate: true,
              repeat: true,
              reverse: true, onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward().whenComplete(() => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        isLogged ? const Home() : const Authenticate()),
              ));
      })),
    );
  }
}
