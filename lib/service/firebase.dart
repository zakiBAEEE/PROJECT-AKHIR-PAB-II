import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:red_wine/models/komentar.dart';
import 'package:red_wine/models/menu.dart';

class MenuService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _notesCollection =
      _database.collection('menu');
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addNote(Menu menu) async {
    Map<String, dynamic> newNote = {
      'title': menu.title,
      'imageUrl': menu.imageUrl,
      'description': menu.description,
      'harga': menu.harga,
      'jenis': menu.jenis,
      'kategori': menu.kategori,
      'toko': menu.toko,
      'isFavorite': menu.isFavorite,
      'isPromo': menu.isPromo,
      'jamBuka': menu.jamBuka,
      'la'
          'created_at': FieldValue.serverTimestamp(),
      'update_at': FieldValue.serverTimestamp(),
    };
    await _notesCollection.add(newNote);
  }

// ==========================================================================
  static Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('images/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
  // ==========================================================================

  Future<void> updateNote(Menu menu) async {
    Map<String, dynamic> updatedNote = {
      'title': menu.title,
      'imageUrl': menu.imageUrl,
      'description': menu.description,
      'harga': menu.harga,
      'jenis': menu.jenis,
      'kategori': menu.kategori,
      'toko': menu.toko,
      'isFavorite': menu.isFavorite,
      'isPromo': menu.isPromo,
      'jamBuka': menu.jamBuka,
      'created_at': menu.createdAt,
      'update_at': FieldValue.serverTimestamp()
    };

    await _notesCollection.doc(menu.id).update(updatedNote);
  }

  static Future<void> deleteNote(Menu menu) async {
    await _notesCollection.doc(menu.id).delete();
  }

  Future<QuerySnapshot> retrieveNote() {
    return _notesCollection.get();
  }

  static Stream<List<Menu>> getNoteList() {
    return _notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Menu(
            id: doc.id,
            title: data['title'],
            description: data['description'],
            imageUrl: data['imageUrl'],
            createdAt: data['created_at'] != null
                ? data['created_at'] as Timestamp
                : null,
            updateAt: data['updated_at'] != null
                ? data['updated_at'] as Timestamp
                : null,
            harga: data['harga'],
            jenis: data['jenis'],
            kategori: data['kategori'],
            isFavorite: data['isFavorite'],
            isPromo: data['isPromo'],
            jamBuka: data['jamBuka'],
            toko: data['toko']);
      }).toList();
    });
  }

  static Stream<List<Komentar>> getKomentarList(String menuId) {
    return _notesCollection
        .doc(menuId)
        .collection('komentar')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Komentar(
          id: doc.id,
          komentar: data['komentar'],
        );
      }).toList();
    });
  }

  Future<void> addKomentar(Komentar komen, String menuId) async {
    Map<String, dynamic> newKomen = {
      'komentar': komen.komentar,
      'created_at': FieldValue.serverTimestamp(),
      'update_at': FieldValue.serverTimestamp(),
    };
    await _notesCollection.doc(menuId).collection('komentar').add(newKomen);
  }
}
