import 'package:clearcuts/Presentation/main_video_panel.dart';
import 'package:flutter/material.dart';
import 'Presentation/home_screen.dart';
import 'Presentation/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clear Cuts',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/upload': ( context) => MainVideoPanel(),
      },
    );
  }
}