import 'package:cloud_firestore/cloud_firestore.dart';

class Pengguna {
  String? id;
  String? idUser;
  String nama;
  String email;
  String jenisUser;
  String? imageUrl;
  Timestamp? createdAt;
  Timestamp? updateAt;

  Pengguna(
      {this.id,
      this.idUser,
      required this.nama,
      required this.email,
      required this.jenisUser,
      this.imageUrl,
      this.createdAt,
      this.updateAt});

  factory Pengguna.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Pengguna(
      id: doc.id,
      idUser: data['idUser'],
      nama: data['nama'],
      email: data['email'],
      jenisUser: data['jenisUser'],
      imageUrl: data['imageUrl'],
      createdAt: data['created_at'] as Timestamp,
      updateAt: data['update_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'idUser': idUser,
      'nama': nama,
      'email': email,
      'jenisUser': jenisUser,
      'imageUrl': imageUrl,
      'created_at': createdAt,
      'update_at': updateAt,
    };
  }
}
