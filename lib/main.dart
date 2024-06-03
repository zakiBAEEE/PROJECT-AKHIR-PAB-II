
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:red_wine/screens/my_app_wrapper.dart';
import 'package:red_wine/widget/theme_provider.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => Themeprovider()..getTheme(),
      child: const MyAppWrapper(),
      ),
  );
}




