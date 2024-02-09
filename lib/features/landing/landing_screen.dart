import 'package:flutter/material.dart';
import 'package:whatsapp0909/common/utils/colors.dart';
import 'package:whatsapp0909/common/widgets/custom_button.dart';
import 'package:whatsapp0909/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context){
     Navigator.pushNamed(context, LoginScreen.named);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height/12,),
            Image.asset(
              'assets/bg.png',
              height: 280,
              width: 280,
              color: tabColor,
            ),
            SizedBox(height: size.height/12,),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service',
                style: TextStyle(color: greyColor),
                textAlign: TextAlign.center,
                ),
            ),
              const SizedBox(height: 10,),
              SizedBox(
                width: size.width*0.75,
                child: CustomButton(
                  onPressed: () => navigateToLoginScreen(context), 
                  text: 'AGREE AND CONTINUE'
                ),
              )
          ],
        )
      ),
    );
  }
}