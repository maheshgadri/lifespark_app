import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:lifespark_app/screens/home_screen.dart';
import 'package:lifespark_app/screens/login_screen.dart';
import 'package:lifespark_app/screens/otp_verify_screen.dart';
import 'package:lifespark_app/db/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Load the stored email from the local database
  String? email = await DBHelper().getEmail();

  runApp(MyApp(initialRoute: email != null ? '/home' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/verify', page: () => VerifyScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
