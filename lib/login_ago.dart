import 'package:flutter/material.dart';

class LoginAgoScreen extends StatefulWidget {
  const LoginAgoScreen({super.key});

  @override
  State<LoginAgoScreen> createState() => _LoginAgoScreenState();
}

class _LoginAgoScreenState extends State<LoginAgoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('こんにちは')),
    );
  }
}