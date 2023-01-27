
import 'package:facebook_app/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupScreenController>(
        init: SignupScreenController(),
        builder: (_) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              
              title: Text("Signup Screen"),
              actions: [TextButton(onPressed: ()  {
              
              Get.to(LoginScreen());
              }, child: Text("Login", style: TextStyle(color: Colors.white),))],
              
            ),
            body: Column(
              
              children: [
              
                TextFormField(
                  controller: _.emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: _.validateEmail,
                ),
                TextFormField(
                  controller: _.passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  validator: _.validatePassword,
                ),
                TextFormField(
                  controller: _.nameController,
                  decoration: InputDecoration(
                    hintText: "name",
                  ),
                  validator: _.validateName,
                ),
                TextFormField(
                  controller: _.numberController,
                  decoration: InputDecoration(
                    hintText: "number",
                  ),
                  validator: _.validatePhone,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _.signUpUser(email: _.emailController.text, userName: _.nameController.text, password: _.passwordController.text, phone: _.numberController.text);
                      // await _.uploadImagetoFirebasestorage(context);
                       Get.to(LoginScreen());
                    },
                    child: Text("SignUp")),
                    
              ],
            ),
          );
        }
        );
  }
}
