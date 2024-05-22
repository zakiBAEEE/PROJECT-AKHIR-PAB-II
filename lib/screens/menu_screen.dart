import 'package:flutter/material.dart';
import 'package:red_wine/widget/card_menu.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Makanan",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: const Color.fromARGB(255, 130, 122, 146),
            ),
            CardMenu(),
            SizedBox(
              height: 40,
            ),
            Text(
              "Minuman",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: const Color.fromARGB(255, 130, 122, 146),
            ),
          ],
        ),
      ),
    );
  }
}
