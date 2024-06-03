import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/service/firebase.dart';

class ListPostinganScreen extends StatefulWidget {
  final String namaUser;
  const ListPostinganScreen({Key? key, required this.namaUser});

  @override
  State<ListPostinganScreen> createState() => _ListPostinganScreenState();
}

class _ListPostinganScreenState extends State<ListPostinganScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Postingan")),
      body: StreamBuilder(
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
                    .where((document) => document.toko == widget.namaUser)
                    .toList();

                return ListView(
                  padding: const EdgeInsets.all(30),
                  children: postingan.map((document) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => NoteEditScreen(note: document),
                          //   ),
                          // );
                        },
                        child: Column(
                          children: [
                            document.imageUrl != null &&
                                    Uri.parse(document.imageUrl!).isAbsolute
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: document.imageUrl!,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: 320,
                                      placeholder: (context, url) =>
                                          const Center(
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
                              title: Text(document.title),
                              subtitle: Text(document.description),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(
                                  //   icon: const Icon(Icons.map),
                                  //   onPressed: document.latitude != null &&
                                  //           document.longitude != null
                                  //       ? () {
                                  //           // _launchMaps(document.latitude!,
                                  //           //     document.longitude!);
                                  //           Navigator.push(
                                  //             context,
                                  //             MaterialPageRoute(
                                  //               builder: (context) =>
                                  //                   GoogleMapsScreen(
                                  //                 latitude: document.latitude!,
                                  //                 longitude: document.longitude!,
                                  //               ),
                                  //             ),
                                  //           );
                                  //         }
                                  //       : null, // Disable the button if latitude or longitude is null
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Konfirmasi Hapus'),
                                            content: Text(
                                                'Yakin ingin menghapus data \'${document.title}\' ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Hapus'),
                                                onPressed: () {
                                                  // NoteService.deleteNote(document)
                                                  //     .whenComplete(() =>
                                                  //         Navigator.of(context)
                                                  //             .pop());
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Icon(Icons.delete),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          }),
    );
  }
}
