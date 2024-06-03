import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_wine/screens/home_screen.dart';
import 'package:red_wine/screens/menu_screen.dart';
import 'package:red_wine/screens/profile_screen_pelanggan.dart';
import 'package:red_wine/screens/profile_screen_toko.dart';
import 'package:red_wine/screens/sign_in_screen.dart';
import 'package:red_wine/screens/toko_screen.dart';
import 'dart:async';
import 'package:red_wine/service/firebase.dart';
import 'package:red_wine/widget/theme_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String searchString = "";

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  Future<String> getUserRole() async {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    Stream userStream = MenuService.getUser(idUser);

    Completer<String> completer = Completer<String>();

    userStream.listen((dynamic user) {
      completer.complete(user.jenisUser);
    });

    return completer.future;
  }

  List<Widget> getTabs() {
    return [
      const HomeScreen(),
      MenuScreen(searchQuery: searchString),
      // const FavoriteMenuScreen(favoriteMenus: []),
      const TokoScreen(),
      const ProfileScreenPelanggan(), // Defaultnya ProfileScreenPelanggan
    ];
  }

  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context);
    return FutureBuilder(
      future: getUserRole(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        Widget profileScreen;
        if (snapshot.connectionState == ConnectionState.waiting) {
          profileScreen = const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            profileScreen = Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data == 'toko') {
              profileScreen = const ProfileScreenToko();
            } else {
              profileScreen = const ProfileScreenPelanggan();
            }
          }
        }

        List<Widget> tabs = getTabs();
        tabs[3] = profileScreen;

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  _showSignOutDialog(context);
                },
                icon: const Icon(Icons.logout),
              ),
              IconButton(
                icon: Icon(themeProvider.isDark ? Icons.dark_mode : Icons.light_mode),
                onPressed: (){
                  themeProvider.setTheme(!themeProvider.isDark);
                },
                )
            ],
            flexibleSpace: currentTabIndex == 1
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.purple.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  )
                : null,
            title: currentTabIndex == 1
                ? TextField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchString = value;
                      });
                    },
                  )
                : null,
          ),
          body: tabs[currentTabIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTabIndex,
            onTap: (currentIndex) {
              setState(() {
                currentTabIndex = currentIndex;
              });
            },
            selectedLabelStyle:
                const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            selectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.black),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store, color: Colors.black),
                label: 'Toko',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: Colors.black),
                label: 'Profile',
              )
            ],
          ),
        );
      },
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Set to false to prevent dismissal by tapping outside the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Call the signOut function and close the dialog
                signOut(context);
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
