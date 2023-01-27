import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class SignupScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  

  ////////////////////////Variable for text formfield///////////////////////////
  String emailtext = 'Email';
  String passwordtext = 'Password';
  String nametext = ' Full Name';
  String phonetext = 'Phone No';
  Icon personicons = const Icon(Icons.person);
  Icon phoneicons = const Icon(Icons.phone);
  Icon emailicons = const Icon(Icons.email);
  Icon passwordicons = const Icon(Icons.lock);
  
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  ////////////////////////Validation for Email///////////////////////////
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    }
    if (!GetUtils.isEmail(value)) {
      return "Enter Valid Email";
    }
    return null;
  }

  ////////////////////////Validation for Password///////////////////////////
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Password";
    }
    if (value.length < 8) {
      return "Enter Valid Password";
    }
    return null;
  }

  ////////////////////////Validation for UserName///////////////////////////
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Name";
    }
    if (value.contains('[a-zA-Z]')) {
      return "Enter a Valid Name";
    }
    return null;
  }

  ////////////////////////Validation for Phone No///////////////////////////
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Phone no";
    }
    // if (value.isPhoneNumber) {
    //   return "Enter a Valid Phone no";
    // }
    return null;
  }

  //////////////////////Sign Up on pressed///////////////////////////
 Future<bool> signUpUser({
  required String email,
  required String password,
  required String userName,
  required String phone,
}) async {
  bool status = false;
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? currentUser = credential.user;

    if (currentUser != null) {
      Map<String, dynamic> userProfileData = {
        "name": userName,
        "email": email,
         "uid" : currentUser.uid,
         "phone":phone

      };
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          lastName: userName,
          imageUrl: "imageUrl",
          id: credential.user!.uid,
          firstName: userName,
          metadata: userProfileData,
        )
      );
    //   DocumentReference currentUserReference =
    //       userReference.doc(currentUser.uid);
    //   Map<String, dynamic> userProfileScreen = {
    //     "name": userName,
    //     "email": email,
    //     "uid": currentUser.uid,
    //
    //   };
    //   await currentUserReference.set(userProfileScreen);
    }
    status = true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    Get.snackbar(
      "About User",
      "User Massage",
      backgroundColor: Colors.amber,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "Account Creation Failed",
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(
        e.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
  return status;
}}