import 'package:cloud_firestore/cloud_firestore.dart';

class Komentar {
  String? id;
  String? komentar;
  Timestamp? createdAt;
  Timestamp? updateAt;

  Komentar(
      {this.id,
      this.komentar,
      this.createdAt,
      this.updateAt});

  factory Komentar.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Komentar(
      id: doc.id,
      komentar: data['komentar'],
      createdAt: data['created_at'] as Timestamp,
      updateAt: data['update_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'komentar' : komentar,
      'created_at': createdAt,
      'update_at': updateAt,
    };
  }
}
