import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:raindrops/firstpage.dart';
import 'package:raindrops/homepage.dart';

void main()
{
  runApp(MyApp());
   WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  Geolocator.requestPermission(); // Request permissions on startup
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}