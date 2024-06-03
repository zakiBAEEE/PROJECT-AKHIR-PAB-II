// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:red_wine/models/user.dart';
// import 'package:red_wine/screens/profile_screen_toko_user.dart';
// import 'package:red_wine/service/firebase.dart';

// class TokoScreen extends StatefulWidget {
//   const TokoScreen({super.key});

//   @override
//   State<TokoScreen> createState() => _TokoScreenState();
// }

// class _TokoScreenState extends State<TokoScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Daftar Toko',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: MenuService.getAllToko(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             default:
//               // Mengakses data dari snapshot
//               List<Pengguna> allToko = snapshot.data ?? [];

//               return ListView.builder(
//                 itemCount: allToko.length,
//                 itemBuilder: (context, index) {
//                   Pengguna toko = allToko[index];
//                   return Card(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProfileScreenTokoUser(
//                               idUser: toko.idUser!,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Column(
//                         children: [
//                           toko.imageUrl != null &&
//                                   Uri.parse(toko.imageUrl!).isAbsolute
//                               ? ClipRRect(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(16),
//                                     topRight: Radius.circular(16),
//                                   ),
//                                   child: CachedNetworkImage(
//                                     imageUrl: toko.imageUrl!,
//                                     fit: BoxFit.cover,
//                                     alignment: Alignment.center,
//                                     width: double.infinity,
//                                     height: 150,
//                                     placeholder: (context, url) => const Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         const Center(
//                                       child: Icon(Icons.error),
//                                     ),
//                                   ),
//                                 )
//                               : Container(),
//                           ListTile(
//                             title: Text(toko.nama),
//                             subtitle: Text(toko.email),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/models/user.dart';
import 'package:red_wine/screens/profile_screen_toko_user.dart';
import 'package:red_wine/service/firebase.dart';

class TokoScreen extends StatefulWidget {
  const TokoScreen({super.key});

  @override
  State<TokoScreen> createState() => _TokoScreenState();
}

class _TokoScreenState extends State<TokoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Toko',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: MenuService.getAllToko(),
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
              // Mengakses data dari snapshot
              List<Pengguna> allToko = snapshot.data ?? [];

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75, // Sesuaikan sesuai kebutuhan
                ),
                itemCount: allToko.length,
                itemBuilder: (context, index) {
                  Pengguna toko = allToko[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreenTokoUser(
                              idUser: toko.idUser!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          toko.imageUrl != null &&
                                  Uri.parse(toko.imageUrl!).isAbsolute
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: toko.imageUrl!,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: 150,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                      child: Icon(Icons.error),
                                    ),
                                  ),
                                )
                              : Container(),
                          ListTile(
                            title: Text(toko.nama),
                            subtitle: Text(toko.email),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
