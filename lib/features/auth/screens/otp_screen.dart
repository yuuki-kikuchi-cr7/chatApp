import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp0909/features/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String named = '/otp-screen';
  final String verificationId;
  const OTPScreen(this.verificationId, {super.key});

void verifyOTP({
   required WidgetRef ref, 
   required BuildContext context, 
   required String userOTP
   }){
  ref
  .read(authControllerProvider)
  .verifyOTP(verificationId: verificationId, context: context, userOTP: userOTP);
}

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: size.width*0.5,
              child:  TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(fontSize: 33),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value){
                  if(value.length == 6){
                   verifyOTP(
                    ref: ref, 
                    context: context, 
                    userOTP: value.trim()
                    );
                  }
                },
              ),
              
            )
          ],
        ),
      ),
    );
  }
}