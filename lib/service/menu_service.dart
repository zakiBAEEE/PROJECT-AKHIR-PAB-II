import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_wine/models/menu.dart';

class MenuService {
  static Stream<List<Menu>> getProdukList() {
    return FirebaseFirestore.instance
        .collection('menus')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Menu.fromDocument(doc, doc['idToko']))
            .toList());
  }

  static Stream<List<Menu>> searchMenus(String query) {
    return FirebaseFirestore.instance
        .collection('menus')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: '$query\uf8ff')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Menu.fromDocument(doc, doc['idToko']))
            .toList());
  }
}