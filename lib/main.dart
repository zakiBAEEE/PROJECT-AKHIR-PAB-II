import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/controller/app_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:red_wine/screens/sign_in_screen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
     MaterialApp(
      title: 'Anggur Merah',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          if(snapshot.hasData){
            return MyApp();
          }
          else{
            return SignInScreen();
          }
        }
        ),
    ),
  );
}



