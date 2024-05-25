import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:red_wine/models/komentar.dart';
import 'package:red_wine/models/menu.dart';

class MenuService{
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
      'jamBuka' : menu.jamBuka,
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
      'jamBuka' : menu.jamBuka,
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

  // static Stream<List<Menu>> getNoteList() {
  //   return _notesCollection.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       return Menu(
  //           id: doc.id,
  //           title: data['title'],
  //           description: data['description'],
  //           imageUrl: data['imageUrl'],
  //           createdAt: data['created_at'] != null
  //               ? data['created_at'] as Timestamp
  //               : null,
  //           updateAt: data['updated_at'] != null
  //               ? data['updated_at'] as Timestamp
  //               : null,
  //           harga: data['harga'],
  //           jenis: data['jenis'],
  //           kategori: data['kategori'],
  //           isFavorite: data['isFavorite'],
  //           isPromo: data['isPromo'],
  //           jamBuka: data['jamBuka'],
  //           toko: data['toko']);
  //     }).toList();
  //   });
  // }

  static Stream<List<Menu>> getNoteList() {
    return _notesCollection.snapshots().asyncMap((snapshot) async {
      final menus = await Future.wait(snapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Query untuk mendapatkan koleksi komentar terkait
        final komentarSnapshot = await _notesCollection
            .doc(doc.id)
            .collection('komentar')
            .get();

        final komentarList = komentarSnapshot.docs.map((komentarDoc) {
          Map<String, dynamic> komentarData = komentarDoc.data() as Map<String, dynamic>;
          return Komentar(
            id: komentarDoc.id,
            komentar: komentarData['komentar'],
          );
        }).toList();

        return Menu(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          createdAt: data['created_at'] != null ? data['created_at'] as Timestamp : null,
          updateAt: data['updated_at'] != null ? data['updated_at'] as Timestamp : null,
          harga: data['harga'],
          jenis: data['jenis'],
          kategori: data['kategori'],
          isFavorite: data['isFavorite'],
          isPromo: data['isPromo'],
          jamBuka: data['jamBuka'],
          toko: data['toko'],
          komentar: komentarList, // Menambahkan list komentar
        );
      }).toList());

      return menus;
    });
  }
}
