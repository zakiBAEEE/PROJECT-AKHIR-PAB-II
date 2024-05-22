import 'package:flutter/material.dart';
import 'package:red_wine/screens/home_screen.dart';
import 'package:red_wine/screens/menu_screen.dart';
import 'package:red_wine/screens/order_screen.dart';
import 'package:red_wine/screens/profile_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Tabs = [
    const HomeScreen(),
    const MenuScreen(),
    const OrderScreen(),
    const ProfileScreen()
  ];
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (currentIndex) {
          currentTabIndex = currentIndex;
          setState(() {});
        },
        selectedLabelStyle:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book, color: Colors.black), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books, color: Colors.black),
              label: 'Order'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box, color: Colors.black),
              label: 'Profile')
        ],
      ),
    );
  }
}
