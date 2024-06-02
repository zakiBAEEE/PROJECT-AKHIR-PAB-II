// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:red_wine/screens/home_screen.dart';
// import 'package:red_wine/screens/menu_screen.dart';
// import 'package:red_wine/screens/profile_screen.dart';
// import 'package:red_wine/screens/favorite_screen.dart';
// import 'package:red_wine/screens/sign_in_screen.dart';

// class MyApp extends StatefulWidget {
  
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {

  
// Future<void>signOut(BuildContext context) async {
//  await FirebaseAuth.instance.signOut();
//  Navigator.of(context).pushReplacement(
//  MaterialPageRoute(builder: (context) => SignInScreen()));
//  }


//   final TextEditingController _searchController = TextEditingController();

//   final Tabs = [
//     const HomePage(),
//     const MenuScreen(),
//     const FavoriteMenuScreen(favoriteMenus: [],),
//     const ProfileScreen()
//   ];
//   int currentTabIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [IconButton(
//  onPressed: () {
//  signOut(context);
//  },
//  icon: const Icon(Icons.logout),
//  ),
// ],
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.deepPurple, Colors.purple.shade300],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: TextField(
//           controller: _searchController,
//           style: const TextStyle(color: Colors.white),
//           cursorColor: Colors.white,
//           decoration: const InputDecoration(
//             hintText: 'Search...',
//             hintStyle: TextStyle(color: Colors.white54),
//             border: InputBorder.none,
//           ),
//           onChanged: (value) {
//             // Perform search functionality here
//           },
//         ),
//       ),
//       body: Tabs[currentTabIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentTabIndex,
//         onTap: (currentIndex) {
//           currentTabIndex = currentIndex;
//           setState(() {});
//         },
//         selectedLabelStyle:
//             const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//         selectedItemColor: Colors.black,
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.search, color: Colors.black), label: 'Search'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.shopify, color: Colors.black),
//               label: 'Keranjang'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.account_box, color: Colors.black),
//               label: 'Profile')
//         ],
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/screens/home_screen.dart';
import 'package:red_wine/screens/menu_screen.dart';
import 'package:red_wine/screens/profile_screen.dart';
import 'package:red_wine/screens/favorite_screen.dart';
import 'package:red_wine/screens/sign_in_screen.dart';

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

  final Tabs = [
    const HomePage(),
    MenuScreen(),
    const FavoriteMenuScreen(favoriteMenus: []),
    const ProfileScreen()
  ];
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
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
        flexibleSpace: currentTabIndex == 1 // Menerapkan gradient hanya di MenuScreen
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
        title: currentTabIndex == 1 // Menampilkan TextField hanya di MenuScreen
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
        selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
            icon: Icon(Icons.shop, color: Colors.black),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
