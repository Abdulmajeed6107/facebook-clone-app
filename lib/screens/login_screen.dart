import 'package:facebook_app/screens/home_screen.dart';
import 'package:facebook_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
        init: LoginScreenController(),
        builder: (_) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("Login"),
            ),
            body: Column(
              children: [
                TextFormField(
                  controller: _.emailController,
                  decoration: InputDecoration(
                    hintText: _.hintEmail,
                  ),
                  validator: _.validateEmail,
                ),
                  TextFormField(
                  controller: _.passwordController,
                  decoration: InputDecoration(
                    hintText: _.hintPassword,
                  ),
                  validator: _.validatePassword,
                ),
                TextButton(
                    onPressed: () {
                      _.onsigninUser();
                      // await _.uploadImagetoFirebasestorage(context);
                      Get.to(HomeScreen());
                    },
                    child: Text("Login")),

                    Text("Don't have an account") ,

                    TextButton(onPressed: (){
                      Get.to(SignUpScreen());
                    }, child: Text("SignUP")),
              ],
            ),
          );
        }
    );
    

  }
}