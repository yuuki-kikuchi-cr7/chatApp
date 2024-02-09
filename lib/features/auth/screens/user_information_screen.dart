import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp0909/common/utils/ulils.dart';
import 'package:whatsapp0909/features/auth/controller/auth_controller.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static const String named = '/user-info';
  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  File? image;

  final nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage ()async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void saveUserDataToFirebase(){
    String name = nameController.text.trim();
    if(name.isNotEmpty){
      ref.read(authControllerProvider).saveUserData(
            context: context,
            name: name,
            file: image ?? File('https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'),
          );
    }
  
 }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Stack(
                children: [
                  image == null 
                  ? const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                    ),
                    radius: 64,
                  )
                  :CircleAvatar(
                   backgroundImage: FileImage(image!),
                    radius: 64,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () => selectImage(), 
                      icon: const Icon(
                        Icons.add_a_photo
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  width: size.width*0.85,
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name'
                    ),
                  ),
                ),
                IconButton(
                  onPressed: ()=> saveUserDataToFirebase(), 
                  icon: const Icon(Icons.done)
                )
              ],
             ),
            ],
          ),
         ),
        ),
    );
  }
}