import 'package:facebook_app/screens/bottom_nev_home_screen.dart';
import 'package:facebook_app/screens/home_screen.dart';
import 'package:facebook_app/screens/login_screen.dart';
import 'package:facebook_app/screens/register.dart';
import 'package:facebook_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getFCMToken() async{
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCMToken $token");
}
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
