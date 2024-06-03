import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_wine/models/komentar.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/models/user.dart';
import 'package:path/path.dart' as path;

class MenuService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _database.collection('toko');

  static final FirebaseStorage _storage = FirebaseStorage.instance;

// ========================================================================================
  static Stream<List<Komentar>> getKomentarList(
      String produkId, String tokoId) {
    return _userCollection
        .doc(tokoId)
        .collection('produk')
        .doc(produkId)
        .collection('komentar')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Komentar(
          id: doc.id,
          komentar: data['komentar'],
          namaPengguna: data['namaPengguna'],
          imageUrl: data['imageUrl'],
          idUser: data['idUser'],
        );
      }).toList();
    });
  }

  static Future<void> addKomentar(String komen, String produkId, String tokoId,
      String namaPengguna, String imageUrl, String idUser) async {
    Map<String, dynamic> newKomen = {
      'komentar': komen,
      'namaPengguna': namaPengguna,
      'imageUrl': imageUrl,
      'idUser': idUser,
      'created_at': FieldValue.serverTimestamp(),
      'update_at': FieldValue.serverTimestamp(),
    };
    await _userCollection
        .doc(tokoId)
        .collection('produk')
        .doc(produkId)
        .collection('komentar')
        .add(newKomen);
  }

  static Future<void> updateKomentar(
    Komentar komentar,
    String tokoId,
    String produkId,
    String newKomen,
  ) async {
    Map<String, dynamic> updatedNote = {
      'komentar': newKomen,
      'created_at': komentar.createdAt,
      'updated_at': FieldValue.serverTimestamp(),
    };

    await _userCollection
        .doc(tokoId)
        .collection('produk')
        .doc(produkId)
        .collection('komentar')
        .doc(komentar.id)
        .update(updatedNote);
  }

  static Future<void> deleteKomentar(
    Komentar komentar,
    String tokoId,
    String produkId,
  ) async {
    await _userCollection
        .doc(tokoId)
        .collection('produk')
        .doc(produkId)
        .collection('komentar')
        .doc(komentar.id)
        .delete();
  }
// =====================================================================

  static Stream<List<Menu>> getProdukList() {
    return _userCollection.snapshots().asyncMap((snapshot) async {
      List<Menu> menuList = [];
      for (var doc in snapshot.docs) {
        QuerySnapshot menuSnapshot =
            await doc.reference.collection('produk').get();
        String idToko = doc.id;
        List<Menu> menus = menuSnapshot.docs.map((menuDoc) {
          Map<String, dynamic> data = menuDoc.data() as Map<String, dynamic>;
          return Menu(
            idToko: idToko,
            id: menuDoc.id,
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
            toko: data['toko'],
          );
        }).toList();
        menuList.addAll(menus);
      }
      return menuList;
    });
  }

  static Future<void> addProduk(String tokoId, Menu menu) async {
    Map<String, dynamic> newProduk = {
      'title': menu.title,
      'description': menu.description,
      'imageUrl': menu.imageUrl,
      'harga': menu.harga,
      'isFavorite': false,
      'isPromo': menu.isPromo,
      'jamBuka': menu.jamBuka,
      'jenis': menu.jenis,
      'kategori': menu.kategori,
      'toko': menu.toko,
      'created_at': FieldValue.serverTimestamp(),
      'update_at': FieldValue.serverTimestamp(),
    };
    await _userCollection.doc(tokoId).collection('produk').add(newProduk);
  }

// ==================================================================================
  static Future<void> addUser(
      String idUser, String nama, String email, String jenisUser) async {
    Map<String, dynamic> newUser = {
      'idUser': idUser,
      'nama': nama,
      'email': email,
      'jenisUser': jenisUser,
      'imageUrl': "",
      'created_at': FieldValue.serverTimestamp(),
      'update_at': FieldValue.serverTimestamp(),
    };
    await _userCollection.add(newUser);
  }

  static Stream<Pengguna> getUser(String idUser) {
    return _userCollection
        .where('idUser', isEqualTo: idUser)
        .snapshots()
        .map((snapshot) {
      var doc = snapshot.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Pengguna(
        id: doc.id,
        idUser: data['idUser'],
        nama: data['nama'],
        email: data['email'],
        imageUrl: data['imageUrl'],
        jenisUser: data['jenisUser'],
      );
    });
  }

  static Future<void> updateUser(Pengguna user, String namaBaru) async {
    Map<String, dynamic> updateUser = {
      'nama': namaBaru,
    };

    QuerySnapshot querySnapshot =
        await _userCollection.where('idUser', isEqualTo: user.idUser).get();

    // Iterasi melalui hasil pencarian
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      // Mendapatkan id dokumen
      String docId = doc.id;
      // Memperbarui dokumen dengan id yang ditemukan
      await _userCollection.doc(docId).update(updateUser);
    }
  }

  static Future<void> updateUserPhoto(Pengguna user) async {
    Map<String, dynamic> updateUser = {
      'imageUrl': user.imageUrl,
    };

    QuerySnapshot querySnapshot =
        await _userCollection.where('idUser', isEqualTo: user.idUser).get();

    // Iterasi melalui hasil pencarian
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      // Mendapatkan id dokumen
      String docId = doc.id;
      // Memperbarui dokumen dengan id yang ditemukan
      await _userCollection.doc(docId).update(updateUser);
    }
  }

  static Future<String?> uploadImage(XFile imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('user/$fileName');

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(await imageFile.readAsBytes());
      } else {
        uploadTask = ref.putFile(File(imageFile.path));
      }

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  // ======================================================================================================
}
