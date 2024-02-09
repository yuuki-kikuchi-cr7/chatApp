import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp0909/common/utils/colors.dart';
import 'package:whatsapp0909/common/utils/ulils.dart';
import 'package:whatsapp0909/common/widgets/custom_button.dart';
import 'package:whatsapp0909/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String named = '/login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

@override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry(){
    showCountryPicker(
  context: context, 
  onSelect: (Country country) {
    setState(() {
      this.country = country;
    });
  },
 );
}

void sendPhoneNumber(){
  String phoneNumber = phoneController.text.trim();
  if(country != null && phoneNumber.isNotEmpty){
    ref
  .read(authControllerProvider)
  .verifyPhoneNumber(phoneNumber: '+${country!.phoneCode}$phoneNumber', context: context);
  }else{
    showSnackBar(
      context: context, 
      content: 'Fill out all the fields');
  }
 }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'WhatsApp will need to verify your phone number.',
                ),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: pickCountry, 
                child: const Text('Pick Country'),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  // if(country != null)
                  // Text('+${country!.phoneCode}'),
                country == null
                 ? const Text(
                  '- -',
                  )
                 : Text('+${country!.phoneCode}',),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: size.width*0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height*0.5,),
              SizedBox(
                width: 90,
                child: CustomButton(
                  onPressed:sendPhoneNumber, 
                  text: 'NEXT'
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}