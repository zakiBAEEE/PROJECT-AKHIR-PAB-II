import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/widget/card_cart.dart';

class FavoriteMenuScreen extends StatefulWidget {
  final List<Menu> favoriteMenus;

  const FavoriteMenuScreen({super.key, required this.favoriteMenus});

  @override
  State<FavoriteMenuScreen> createState() => _FavoriteMenuScreenState();
}

class _FavoriteMenuScreenState extends State<FavoriteMenuScreen> {
  late List<Menu> _favoriteMenus;

  @override
  void initState() {
    super.initState();
    _favoriteMenus = widget.favoriteMenus;
  }

  Future<void> _toggleFavorite(Menu menu) async {
    setState(() {
      if (_favoriteMenus.contains(menu)) {
        _favoriteMenus.remove(menu);
      } else {
        _favoriteMenus.add(menu);
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Menus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keranjang Anda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _favoriteMenus.length,
                itemBuilder: (context, index) {
                  return CardCart(
                    menu: _favoriteMenus[index],
                    id: index.toString(),
                    onFavoriteToggle: () => _toggleFavorite(_favoriteMenus[index]),
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
