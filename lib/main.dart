import 'package:flutter/material.dart';
import 'package:red_wine/controller/app_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(
    const MaterialApp(
      title: 'RedWine',
      home: MyApp(),
    ),
  );
}
