import 'package:flutter/material.dart';
import 'package:red_wine/controller/app_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

<<<<<<< HEAD
import 'package:red_wine/screens/sign_in_screen.dart';
=======
import 'package:red_wine/screens/welcome_screen.dart';

>>>>>>> 867bd096adc9a3345cecf83fa3e01fe68fe85a30

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      title: 'Anggur Merah',
<<<<<<< HEAD
      home: SignInScreen(),
=======
      home: WelcomePage(),
>>>>>>> 867bd096adc9a3345cecf83fa3e01fe68fe85a30
    ),
  );
}



