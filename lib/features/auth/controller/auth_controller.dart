import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp0909/features/auth/repository/auth_repository.dart';
import 'package:whatsapp0909/models/user_models.dart';

final userDataAuthProvider = FutureProvider((ref){
final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

final authControllerProvider = Provider(
  (ref){
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(
      authRepository: authRepository, 
      ref: ref
      );
   }
  );

class AuthController{
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({
    required this.authRepository, 
    required this.ref,
    });

    Future<UserModel?> getUserData()async{
       UserModel? user = await authRepository.getcurrentUserData();
       return user;
    }

    void verifyPhoneNumber ({
      required String phoneNumber,
      required BuildContext context
      }){
       authRepository.verifyPhoneNumber(
        phoneNumber: phoneNumber, 
        context: context,
        );
    }

    void verifyOTP({
     required String verificationId, 
     required BuildContext context, 
     required String userOTP
   }){
     authRepository.verifyOTP(
      verificationId: verificationId, 
      context: context, 
      userOTP: userOTP
      );
    }

    void saveUserData({
      required BuildContext context,
      required String name,
      required File file
      }){
      authRepository.saveUserDataToFirebase(context: context, name: name, profilePic: file, ref: ref);
    }


}