
import 'package:dataspottest2/pages/home.dart';
import 'package:dataspottest2/pages/login.dart';
import 'package:dataspottest2/pages/register.dart';
import 'package:dataspottest2/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp( MyApp());
  }


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splas_screen',
      routes: {
        'splas_screen': (context) => WelcomeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'home_screen': (context) => HomePage()
      },
    );
  }
}