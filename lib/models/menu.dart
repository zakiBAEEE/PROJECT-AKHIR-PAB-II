import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String? idToko;
  String? id;
  final String title;
  String? imageUrl;
  final String description;
  final String harga;
  final String jenis;
  final String kategori;
  final String toko;
  final bool isFavorite;
  final bool isPromo;
  final String jamBuka;
  Timestamp? createdAt;
  Timestamp? updateAt;

  Menu(
      {this.idToko,
      this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.harga,
      required this.jenis,
      required this.kategori,
      required this.toko,
      required this.isFavorite,
      required this.isPromo,
      required this.jamBuka,
      this.createdAt,
      this.updateAt});

  factory Menu.fromDocument(DocumentSnapshot doc, String idToko) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Menu(
      idToko: idToko,
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

  get name => null;

  Map<String, dynamic> toDocument() {
    return {
      'idToko': idToko,
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'jenis': jenis,
      'kategori': kategori,
      'toko': toko,
      'harga': harga,
      'isFavorite': isFavorite,
      'isPromo': isPromo,
      'jamBuka': jamBuka,
      'created_at': createdAt,
      'update_at': updateAt,
    };
  }
}
