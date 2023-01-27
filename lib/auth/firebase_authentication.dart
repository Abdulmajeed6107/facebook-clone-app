

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  static CollectionReference userReference = FirebaseFirestore.instance.collection("users");

  static String uid = "";

  static User? userstate = FirebaseAuth.instance.currentUser;

  static UserId(){
    if(userstate != null){
      uid = userstate!.uid;
    }
  }

  static Future<bool> signinUser (
    {required String email, required String passowrd,}) async{
      bool status = false;
      try {
        final Credential = await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: email, password: passowrd);
        status = true;
        print(status);
      }on FirebaseAuthException catch (e){
        if(e.code == 'user-not-found'){
          print("no user found for this email");
        }else{
          if(e.code == 'wrong-password'){
            print('wrong password provided for that user');
          }
          
        }
        
      }
      return status;
    }
    static Future<bool>signUpUser({
      required String email,
      required String password,
      required String name,
      required String phone,

    }) async {
      bool status = false;
      try {
        final credential = await FirebaseAuth.instance.
        createUserWithEmailAndPassword(email: email, password: password);

        User? currentUser = credential.user;
        if(currentUser != null){
          DocumentReference currentUserReference = userReference.doc(currentUser.uid);
          Map<String, dynamic> userProfileData = {
            "phone": phone,
            "name": name,
            "email": email,
            "uid": currentUser.uid,
           
          
          };
          await currentUserReference.set(userProfileData);
        } 
        status = true;
      } on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          print('the password provided is too weak');
        }else if( e.code == 'email-already-in-use'){
          print("the acount already exist for that email");
        }
         
        
      } catch (e){
        print(e);
      }
        return status;
    }
  
}