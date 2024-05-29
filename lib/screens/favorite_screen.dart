import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/widget/card_favorite.dart';

class FavoriteMenuScreen extends StatelessWidget {
  final List<Menu> favoriteMenus;
   

  const FavoriteMenuScreen({super.key, required this.favoriteMenus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu Favorite Anda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: favoriteMenus.length,
                itemBuilder: (context, index) {
                  return FavoriteMenuItem(
                    menu: favoriteMenus[index],
                    id: index.toString(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
