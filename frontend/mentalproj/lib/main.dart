import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentalproj/screens/main_screen.dart';

import 'package:mentalproj/screens/test_voice_send.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 4, 21, 0)),
        primaryColor: Color.fromARGB(255, 4, 21, 0),
        dialogBackgroundColor: Color.fromARGB(255, 200, 226, 201),
        cardColor: Color.fromARGB(255, 225, 238, 226),
        focusColor: Color.fromARGB(255, 236, 140, 140) ,
        highlightColor: Color.fromARGB(255, 139, 216, 129),

        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 36.0, color: Color.fromARGB(255, 4, 21, 0), fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 26.0, color: Color.fromARGB(255, 4, 21, 0), fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 18.0, color: Color.fromARGB(255, 4, 21, 0), ),

          bodySmall: TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 4, 21, 0), )
          ),

      
        
        useMaterial3: true,
      ),
       home: MainScreen(),
     // home: Container(decoration: BoxDecoration( gradient: LinearGradient(colors: [Colors.white, Color(0xEDEDED)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),),
    );
  }
}

