import 'package:flutter/material.dart';
import 'package:whatsapp0909/common/widgets/error.dart';
import 'package:whatsapp0909/features/auth/screens/login_screen.dart';
import 'package:whatsapp0909/features/auth/screens/otp_screen.dart';
import 'package:whatsapp0909/features/auth/screens/user_information_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case LoginScreen.named:
    return MaterialPageRoute(
      builder: (context) => const LoginScreen()
      );
    case OTPScreen.named:
    final String verificationId = settings.arguments.toString();
    return MaterialPageRoute(
      builder: (context) => OTPScreen(verificationId)
      );
    case UserInfoScreen.named:
    return MaterialPageRoute(
      builder: (context)=> const UserInfoScreen()
      );
      default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
     }
   }