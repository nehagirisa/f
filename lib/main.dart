
import 'package:firebase_extensions/pages/create_blog.dart';
import 'package:firebase_extensions/pages/dashbord.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
     apiKey: "AIzaSyCKOBopRJBPTR_3BD31QRNgBsvTh4vUaJ4",
    authDomain: "summarize-text-88b87.firebaseapp.com",
    projectId: "summarize-text-88b87",
    storageBucket: "summarize-text-88b87.appspot.com",
    messagingSenderId: "1029071223535",
    appId: "1:1029071223535:web:522446e9a7e526d0f0f91a",
    measurementId: "G-4M7E16YM19"
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:  Dashboard(),
    );
  }
}

