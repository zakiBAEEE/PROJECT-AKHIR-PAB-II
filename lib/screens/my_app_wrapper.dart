import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:red_wine/controller/app_user.dart';
import 'package:red_wine/screens/sign_in_screen.dart';
import 'package:red_wine/widget/theme_provider.dart';


class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Themeprovider>(
      builder: (context, themeProvider, child) {
        return GetMaterialApp(
          title: 'Anggur Merah',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MyApp();
              } else {
                return const SignInScreen();
              }
            },
          ),
        );
      },
    );
  }

  
}