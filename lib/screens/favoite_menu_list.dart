import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_wine/models/menu.dart';

class FavoriteMenuList {
  static final FavoriteMenuList _instance = FavoriteMenuList._internal();
  final CollectionReference _favoriteMenusCollection = FirebaseFirestore.instance.collection('favoriteMenus');

  factory FavoriteMenuList() {
    return _instance;
  }

  FavoriteMenuList._internal();

  Future<void> add(Menu menu) async {
    await _favoriteMenusCollection.doc(menu.id!).set(menu.toDocument());
  }

  Future<void> remove(Menu menu) async {
    await _favoriteMenusCollection.doc(menu.id!).delete();
  }

  Future<List<Menu>> getFavorites() async {
    final snapshot = await _favoriteMenusCollection.get();
    return snapshot.docs.map((doc) => Menu.fromDocument(doc, doc.id)).toList();
  }

  Future<bool> contains(Menu menu) async {
    final snapshot = await _favoriteMenusCollection.doc(menu.id!).get();
    return snapshot.exists;
  }
}
