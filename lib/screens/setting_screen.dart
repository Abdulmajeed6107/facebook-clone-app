import 'package:facebook_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.to(HomeScreen());
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Setting"),
      ),
      body: Container(
        color: Colors.red,
        height: 100,
        width: 100,
      ),
    );
  }
}