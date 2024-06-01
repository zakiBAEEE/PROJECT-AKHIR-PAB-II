import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? idUser;
  String nama;
  String email;
  String jenisUser;
  String? imageUrl;
  Timestamp? createdAt;
  Timestamp? updateAt;

  User(
      {this.idUser,
      required this.nama,
      required this.email,
      required this.jenisUser,
      this.imageUrl,
      this.createdAt,
      this.updateAt});

  factory User.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
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
      'idUser' : idUser,
      'nama' : nama,
      'email' : email,
      'jenisUser' : jenisUser,
      'imageUrl' : imageUrl,
      'idUser' : idUser,
      'created_at': createdAt,
      'update_at': updateAt,
    };
  }
}
