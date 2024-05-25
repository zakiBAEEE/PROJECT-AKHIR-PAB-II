import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/service/firebase.dart';
import 'package:red_wine/widget/card_menu.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

// class _MenuScreenState extends State<MenuScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: MenuService.getNoteList(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           default:
//             return GridView.count(
//               crossAxisCount: 2, // Misalnya, kita ingin grid dengan 2 kolom
//               mainAxisSpacing: 4.0, // Jarak vertikal antara item
//               crossAxisSpacing: 4.0, // Jarak horizontal antara item
//               children: snapshot.data!.map((document) {
//                 return CardMenu(menu: document);
//               }).toList(),
//             );
//         }
//       },
//     );
//   }
// }

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MenuService.getNoteList(),
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
              return Center(child: Text('No data available'));
            }

            // Pisahkan data berdasarkan jenis
            var makanan = snapshot.data!
                .where((document) => document.jenis == 'makanan')
                .toList();
            var minuman = snapshot.data!
                .where((document) => document.jenis == 'minuman')
                .toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bagian Makanan
                    if (makanan.isNotEmpty) ...[
                      Text(
                        'Makanan',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      Container(
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
                            NeverScrollableScrollPhysics(), // Menghindari konflik scrolling dengan SingleChildScrollView
                        children: makanan.map((document) {
                          return CardMenu(menu: document);
                        }).toList(),
                      ),
                    ],

                    // Bagian Minuman
                    if (minuman.isNotEmpty) ...[
                      SizedBox(height: 16.0), // Spasi antara bagian
                      Text(
                        'Minuman',
                         style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: 300,
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),

                      GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: minuman.map((document) {
                          return CardMenu(menu: document);
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
