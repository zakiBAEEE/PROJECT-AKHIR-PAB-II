
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:red_wine/models/komentar.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/models/user.dart';

class MenuService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  
  // static final FirebaseStorage _storage = FirebaseStorage.instance;

  static final CollectionReference _userCollection = _database.collection('toko');

  static Stream<List<Komentar>> getKomentarList(String produkId, String tokoId) {
    return _userCollection.doc(tokoId).collection('produk').doc(produkId).collection('komentar').orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Komentar(
          id: doc.id,
          komentar: data['komentar'],
          namaPengguna: data['namaPengguna'],
          imageUrl: data['imageUrl'],
        );
      }).toList();
    });
  }
 static Future<void> addKomentar(String komen, String produkId, String tokoId, String namaPengguna, String imageUrl) async {
    Map<String, dynamic> newKomen = {
      'komentar': komen,
      'namaPengguna': namaPengguna,
      'imageUrl' : imageUrl,
      'created_at': FieldValue.serverTimestamp(),
      'update_at': FieldValue.serverTimestamp(),
    };
    await _userCollection.doc(tokoId).collection('produk').doc(produkId).collection('komentar').add(newKomen);
        // await _notesCollection.doc(menuId).collection('komentar').add(newKomen);
  }
static Stream<List<Menu>> getProdukList() {
  return _userCollection.snapshots().asyncMap((snapshot) async {
    List<Menu> menuList = [];
    for (var doc in snapshot.docs) {
      QuerySnapshot menuSnapshot = await doc.reference.collection('produk').get();
      String idToko = doc.id;
      List<Menu> menus = menuSnapshot.docs.map((menuDoc) {
        Map<String, dynamic> data = menuDoc.data() as Map<String, dynamic>;
        return Menu(
          idToko: idToko,
          id: menuDoc.id,
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
        );
      }).toList();
      menuList.addAll(menus);
    }
    return menuList;
  });
}


static Future<void> addUser(String idUser, String nama, String email, String jenisUser) async {

    Map<String, dynamic> newUser = {
      'idUser' : idUser,
      'nama': nama,
      'email' : email,
      'jenisUser' : jenisUser,
      'imageUrl' : "",
      'created_at': FieldValue.serverTimestamp(),
      'update_at': FieldValue.serverTimestamp(),
    };
    await _userCollection.add(newUser);
  }

static Stream<User> getUser(String idUser) {
  return _userCollection
      .where('idUser', isEqualTo: idUser)
      .snapshots()
      .map((snapshot) {
      var doc = snapshot.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return User(
        idUser: data['idUser'],
        nama: data['nama'],
        email: data['email'],
        imageUrl: data['imageUrl'],
        jenisUser: data['jenisUser'],
      );
  });
}
}


