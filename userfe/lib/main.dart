import 'package:flutter/material.dart';
import 'package:userfe/screens/auth/login_screen.dart';
import 'package:userfe/screens/home/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home:const HomeScreen() , // <-- Gọi trang Login ở đây const LoginScreen()
    );
  }
}

