import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/screens/home_screen.dart';
import 'package:red_wine/screens/menu_screen.dart';
import 'package:red_wine/screens/profile_screen_pelanggan.dart'; // import ProfileScreenPelanggan
import 'package:red_wine/screens/profile_screen_toko.dart'; // import ProfileScreenToko
import 'package:red_wine/screens/favorite_screen.dart';
import 'package:red_wine/screens/sign_in_screen.dart';
import 'dart:async';
import 'package:red_wine/service/firebase.dart'; // Import untuk Completer

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInScreen()),
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

  final Tabs = [
    const HomeScreen(),
    const MenuScreen(),
    const FavoriteMenuScreen(favoriteMenus: []),
    // ProfileScreen bergantung pada peran pengguna
    // Jadi, kita buat tampilan ProfileScreen dinamis
    ProfileScreenPelanggan(), // Defaultnya ProfileScreenPelanggan
  ];
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserRole(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        Widget profileScreen;
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan loading indicator jika masih dalam proses mendapatkan peran pengguna
          profileScreen = const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            // Menampilkan pesan error jika terjadi kesalahan
            profileScreen = Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Tentukan kelas mana yang akan digunakan berdasarkan peran pengguna
            if (snapshot.data == 'toko') {
              profileScreen = const ProfileScreenToko();
            } else {
              profileScreen = const ProfileScreenPelanggan();
            }
          }
        }

        // Update ProfileScreen pada Tabs
        Tabs[3] = profileScreen;

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                icon: const Icon(Icons.logout),
              ),
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
                      // Perform search functionality here
                    },
                  )
                : null,
          ),
          body: Tabs[currentTabIndex],
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
}
