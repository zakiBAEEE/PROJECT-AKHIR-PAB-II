import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/screens/detail_screen.dart';


class FavoriteMenuScreen extends StatelessWidget {
  const FavoriteMenuScreen({super.key, required List favoriteMenus});

  Future<List<Menu>> _getFavoriteMenus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(user.uid)
        .collection('menus')
        .get();

    return snapshot.docs.map((doc) => Menu.fromDocument(doc, user.uid)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Menus'),
      ),
      body: FutureBuilder<List<Menu>>(
        future: _getFavoriteMenus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading favorite menus'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorite menus found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Menu menu = snapshot.data![index];
                return ListTile(
                  
                  title: Text(menu.title),
                  subtitle: Text(menu.harga),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(menu: menu),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
