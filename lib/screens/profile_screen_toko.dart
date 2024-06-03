import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:red_wine/screens/edit_foto_profil.dart';
import 'package:red_wine/screens/list_postingan_screen.dart';
import 'package:red_wine/service/firebase.dart';
import 'package:red_wine/screens/add_menu.dart';
import 'package:red_wine/widget/card_menu.dart';

class ProfileScreenToko extends StatefulWidget {
  const ProfileScreenToko({Key? key}) : super(key: key);

  @override
  State<ProfileScreenToko> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileScreenToko> {
  String idUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: MenuService.getUser(idUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 80,
                width: double.infinity,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Center(
                  child: TextButton(
                    child: Text(user.nama,
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0))),
                    onPressed: () {
                      TextEditingController _textFieldController =
                          TextEditingController();
                      _textFieldController.text = user.nama.toString();

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Ganti Nama?'),
                            content: TextField(
                              controller: _textFieldController,
                              decoration: const InputDecoration(
                                  hintText: 'Masukkan Nama Anda'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Batal'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Simpan'),
                                onPressed: () {
                                  String editedNama = _textFieldController.text;
                                  // Lakukan pembaruan komentar di sini, misalnya dengan menggunakan MenuService.updateKomentar
                                  MenuService.updateUser(user, editedNama)
                                      .whenComplete(
                                          () => Navigator.of(context).pop());
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 70,
                                    child: ClipOval(
                                      child: user.imageUrl != null &&
                                              user.imageUrl != ""
                                          ? CachedNetworkImage(
                                              imageUrl: user.imageUrl!,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              height: 150,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Center(
                                                child: Icon(Icons.error),
                                              ),
                                            )
                                          : Container(
                                              color: Colors
                                                  .grey, // Warna avatar kosong
                                              child: Icon(Icons.person,
                                                  size: 65,
                                                  color: Colors
                                                      .white), // Icon default untuk avatar kosong
                                            ),
                                    ),
                                  )),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditFotoProfil(
                                                user: user,
                                              )),
                                    );
                                  },
                                  icon: Icon(Icons.camera_alt,
                                      color: const Color.fromARGB(
                                          255, 107, 23, 233)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Pengguna

                      // Penutup
                      const SizedBox(
                        height: 4,
                      ),
                      Divider(
                        color: Colors.deepPurple[100],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddMenu()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 40),
                                    backgroundColor:
                                        const Color.fromARGB(255, 57, 255, 7)),
                                child: const Text(
                                  "Add Postingan",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ],
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ListPostinganScreen(
                                              namaUser: user.nama,
                                              tokoId: user.idUser!,
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 40),
                                    backgroundColor:
                                        const Color.fromARGB(255, 57, 255, 7)),
                                child: const Text(
                                  "Edit Postingan",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              StreamBuilder(
                  stream: MenuService.getProdukList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No data available'));
                        }

                        // Pisahkan data berdasarkan jenis
                        var postingan = snapshot.data!
                            .where((document) => document.toko == user.nama)
                            .toList();

                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Bagian Makanan
                                if (postingan.isNotEmpty) ...[
                                  const Text(
                                    'Postingan',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: Divider(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    shrinkWrap:
                                        true, // Penting untuk menyesuaikan ukuran GridView dengan isinya
                                    physics:
                                        const NeverScrollableScrollPhysics(), // Menghindari konflik scrolling dengan SingleChildScrollView
                                    children: postingan.map((document) {
                                      return CardMenu(menu: document);
                                    }).toList(),
                                  ),
                                ],

                                // Bagian Minuman
                              ],
                            ),
                          ),
                        );
                    }
                  })
            ]),
          );
        },
      ),
    );
  }
}
