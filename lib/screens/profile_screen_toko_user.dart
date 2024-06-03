import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/service/firebase.dart';
import 'package:red_wine/widget/card_menu.dart';

class ProfileScreenTokoUser extends StatefulWidget {
  final String idUser;
  const ProfileScreenTokoUser({Key? key, required this.idUser})
      : super(key: key);

  @override
  State<ProfileScreenTokoUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileScreenTokoUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Toko")),
      body: StreamBuilder(
        stream: MenuService.getUser(widget.idUser),
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
                child: Center(
                  child: Text(user.nama,
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0))),
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
                                              child: const Icon(Icons.person,
                                                  size: 65,
                                                  color: Colors
                                                      .white), // Icon default untuk avatar kosong
                                            ),
                                    ),
                                  )),
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
