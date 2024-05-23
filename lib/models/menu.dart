import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String? id;
  final String title;
  String? imageUrl;
  final String description;
  final String harga;
  final String jenis;
  final String kategori;
  final String toko;
  bool? isFavorite;
  bool? isPromo;
  final String jamBuka;
  Timestamp? createdAt;
  Timestamp? updateAt;

  Menu(
      {this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.harga,
      required this.jenis,
      required this.kategori,
      required this.toko,
      this.isFavorite,
      this.isPromo,
      required this.jamBuka,
      this.createdAt,
      this.updateAt});

  factory Menu.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Menu(
      id: doc.id,
      title: data['title'],
      imageUrl: data['imageUrl'],
      description: data['description'],
      harga: data['harga'],
      jenis: data['jenis'],
      kategori: data['kategori'],
      toko: data['toko'],
      isFavorite: data['isFavorite'],
      isPromo: data['isPromo'],
      jamBuka: data['jamBuka'],
      createdAt: data['created_at'] as Timestamp,
      updateAt: data['update_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'jenis': jenis,
      'kategori': kategori,
      'toko': toko,
      'harga': harga,
      'isFavorite': isFavorite,
      'isPromo': isPromo,
      'jamBuka' : jamBuka,
      'created_at': createdAt,
      'update_at': updateAt,
    };
  }
}
