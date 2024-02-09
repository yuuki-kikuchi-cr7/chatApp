import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp0909/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp0909/common/utils/ulils.dart';
import 'package:whatsapp0909/features/auth/screens/otp_screen.dart';
import 'package:whatsapp0909/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp0909/login_ago.dart';
import 'package:whatsapp0909/models/user_models.dart';


final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance, 
    firestore: FirebaseFirestore.instance
    )
  );

class AuthRepository{
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
   required this.auth,
   required this.firestore
  });

  Future<UserModel?> getcurrentUserData()async{
    UserModel? user;
    final snapshot = await firestore
    .collection('users')
    .doc(auth.currentUser?.uid)
    .get();
   if(snapshot.data() != null ){
     user = UserModel.fromFirestore(snapshot);
     }
     return user;
    }

  void verifyPhoneNumber({
    required String phoneNumber,
    required BuildContext context
    })async{
   try{
    await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential)async{
     await auth.signInWithCredential(credential);
    }, 
    verificationFailed: (FirebaseAuthException e){
      showSnackBar(context: context, content: e.message!);
    }, 
    codeSent: (String verificationId,int? resendToken){
       Navigator.pushNamed(
        context, 
        OTPScreen.named,
        arguments: verificationId
        );
    }, 
    codeAutoRetrievalTimeout: (String verificationId){}
    );
   }catch(e){
     showSnackBar(context: context, content: e.toString());
   }
  }

  void verifyOTP({ 
     required String verificationId, 
     required BuildContext context, 
     required String userOTP
     })async{
      try{
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: userOTP,
     );
    await auth.signInWithCredential(credential);
     Navigator.pushNamedAndRemoveUntil(
      context, 
      UserInfoScreen.named,
      (route) => false);
      } on FirebaseAuthException catch (e){
        showSnackBar(context: context, content: e.message!);
      }
 }

 void saveUserDataToFirebase({
  required BuildContext context,
  required String name,
  required File profilePic,
  required ProviderRef ref
  })async{
  try{
    String uid = auth.currentUser!.uid;
    String phoneNumber = auth.currentUser!.phoneNumber!;

  String photoUrl = await ref.read(commonFirebaseStorageRepository).uploadFile(ref: 'profilePic/$uid', file: profilePic);
  UserModel user = UserModel(
    name: name, 
    uid: uid, 
    profilePic: photoUrl, 
    isOnline: true, 
    phoneNumber: phoneNumber, 
    groupId: [],
    );

  await firestore.collection('users').doc(uid).set(user.toMap());
  Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginAgoScreen(),
        ),
        (route) => false,
      );
 

  }catch(e){
    showSnackBar(context: context, content: e.toString());
  }
 }
}