import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/service/firebase.dart';
import 'package:red_wine/widget/card_menu.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MenuService.getNoteList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return GridView.count(
              crossAxisCount: 2, // Misalnya, kita ingin grid dengan 2 kolom
              mainAxisSpacing: 4.0, // Jarak vertikal antara item
              crossAxisSpacing: 4.0, // Jarak horizontal antara item
              children: snapshot.data!.map((document) {
                return CardMenu(menu: document);
              }).toList(),
            );
        }
      },
    );
  }
}
