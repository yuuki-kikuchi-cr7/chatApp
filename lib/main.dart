import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp0909/common/utils/colors.dart';
import 'package:whatsapp0909/common/widgets/error.dart';
import 'package:whatsapp0909/common/widgets/loader.dart';
import 'package:whatsapp0909/features/auth/controller/auth_controller.dart';
import 'package:whatsapp0909/features/landing/landing_screen.dart';
import 'package:whatsapp0909/firebase_options.dart';
import 'package:whatsapp0909/login_ago.dart';
import 'package:whatsapp0909/router.dart';
import 'package:whatsapp0909/screens/mabile_layout_screen.dart';
import 'package:whatsapp0909/screens/mobile_chat_screen.dart';

Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()
    )
  );
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp ',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home:  ref.watch(userDataAuthProvider).when(
        data: (data) {
          if(data == null){
            return const LandingScreen();
          }else{
             return const MobileLayoutScreen();
          }
        }, 
        error: (err,s) => ErrorScreen(error: err.toString()), 
        loading: ()=> const Loader()
        )
    );
  }
}

