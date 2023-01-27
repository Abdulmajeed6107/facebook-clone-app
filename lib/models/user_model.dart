import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UsersModel {
  late final String firstName;
  late final String lastName;
  late final Metadata metadata;
  
  UsersModel({
    required this.firstName,
    required this.lastName,
    required this.metadata,
  });
  
  // UsersModel.fromJson(Map<String, dynamic> doc,String docId){
  //   email = doc['email']??"";
  //   name = doc['name']??"";
  //   // phone = doc['phone'];
  //   uid = doc['uid']??"";
  //   profileImageUrl =doc['profileImageUrl']??"";
  //   coverImageUrl = doc['coverImageUrl']??"";
  //   id=docId;
  // }
  // UsersModel.fromjsons(json json){
  //   firstName = json['firstName'];
  //   lastName = json['lastName'];
  //   metadata = Metadata.fromjsons(json['metadata']);
    
    // phone = doc['phone'];
    // uid = doc['uid']??"";
    // profileImageUrl =doc['profileImageUrl']??"";
    // coverImageUrl = doc['coverImageUrl']??"";
    // id=doc.id;
  UsersModel.fromJson(DocumentSnapshot documentSnapshot){
    firstName = documentSnapshot['firstName']??"";
    lastName = documentSnapshot['lastName']??"";
    metadata = Metadata.fromJson(documentSnapshot['metadata']);
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['email'] = metadata.email;
  //   _data['name'] = metadata.name;
  //   // _data['Phone'] = phone
  //   // _data['coverImageUrl'] = 'coverImageUrl';
  //   return _data;
   }
class Metadata{
  late final String name;
  late final String email;
  late final String phone;
  late final String uid;
  late final String profileImageUrl;
   Metadata({
    required this.email,
    required this.name,
    required this.phone,
    required this.uid,
    required this.profileImageUrl,
  });

   Metadata.fromJson(Map<String, dynamic> json ){
    email = json['email']??"";
    name = json['name']??"";
    phone = json['phone'];
    uid = json['uid']??"";
    profileImageUrl =json['profileImageUrl']??"";
  }

  

}

// class UserModel {
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.uid,
//     required this.dob,
//     required this.gender,
//     required this.education,
//     required this.profileImageUrl,
//     required this.coverImageUrl,
//     required this.dateCreate,
//     required this.dateUpdate,
//     required this.phoneNumber,
//     required this.lat,
//     required this.lng,
//     required this.address,
//   });
//   late final String id;
//   late final String userId;
//   late final String name;
//   late final String email;
//   late final String uid;
//   late final String dob;
//   late final String gender;
//   late final String education;
//   late final String profileImageUrl;
//   late final String coverImageUrl;
//   late final String dateCreate;
//   late final String dateUpdate;
//   late final String phoneNumber;
//   late final String lat;
//   late final String lng;
//   late final String address;
  

//   UserModel.fromJson(Map<String, dynamic> json, String docId){
//     id = json['id']?? '';
//     id = json['userId']??"";
//     name = json['name']??"";
//     email = json['email']??"";
//     uid = json['uid']??"";
//     dob = json['dob']??"";
//     gender = json['gender']??"";
//     education = json['education']??"";
//     profileImageUrl = json['profileImageUrl']??"";
//     coverImageUrl = json['coverImageUrl']??"";
//     dateCreate = json['date_create']??"";
//     dateUpdate = json['date_update']??"";
//     phoneNumber = json['phoneNumber']??"";
//     lat = json['lat']??"";
//     lng = json['lng']??"";
//     address = json['address']??"";
//     id = docId;
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email'] = email;
//     data['uid'] = uid;
//     data['dob'] = dob;
//     data['gender'] = gender;
//     data['education'] = education;
//     data['profileImageUrl'] = profileImageUrl;
//     data['coverImageUrl'] = coverImageUrl;
//     data['date_create'] = dateCreate;
//     data['date_update'] = dateUpdate;
//     data['phoneNumber'] = phoneNumber;
//     data['lat'] = lat;
//     data['lng'] = lng;
//     data['address'] = address;
//     data['userId'] = userId;
//     return data;
//   }
// }