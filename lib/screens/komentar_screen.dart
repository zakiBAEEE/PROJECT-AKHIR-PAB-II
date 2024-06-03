
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/service/firebase.dart';

class ComentarScreen extends StatefulWidget {
    final Menu menu;
  const ComentarScreen({Key? key, required this.menu}) : super(key: key);

  @override
  State<ComentarScreen> createState() => _ComentarScreenState();
}

class _ComentarScreenState extends State<ComentarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => KomentarDialog(id: widget.menu.id!, idToko: widget.menu.idToko!),
          );
        },
        tooltip: 'Tambah Komentar',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("KOMENTAR"),
      ),
      body: ComentarList(
        idProduk: widget.menu.id!,
        idToko: widget.menu.idToko!,
      ),
    );
  }
}

class ComentarList extends StatefulWidget {
  final String idProduk;
  final String idToko;
  const ComentarList({Key? key, required this.idProduk, required this.idToko,});

  @override
  State<ComentarList> createState() => _ComentarListState();
}

class _ComentarListState extends State<ComentarList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MenuService.getKomentarList(widget.idProduk, widget.idToko),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            final komentarList = snapshot.data!;
            return  ListView.builder(
  itemCount: komentarList.length,
  itemBuilder: (context, index) {
    final komentar = komentarList[index];
    // Periksa apakah ID pengguna komentar sama dengan ID pengguna yang saat ini masuk
    final bool isCurrentUserComment = komentar.idUser == FirebaseAuth.instance.currentUser!.uid;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: komentar.imageUrl != null && komentar.imageUrl != ""
              ? CachedNetworkImage(
                  imageUrl: komentar.imageUrl!,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error),
                  ),
                )
              : Container(
                  color: Colors.grey,
                  child: Icon(Icons.person, size: 65, color: Colors.white),
                ),
          ),
        ),
        title: Text(komentar.namaPengguna.toString()),
        subtitle: Text(komentar.komentar.toString()),
        trailing: isCurrentUserComment // Tampilkan tombol hapus hanya jika komentar dari pengguna saat ini
          ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi Hapus'),
                          content: const Text('Yakin ingin menghapus Komentar?'),
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
                                MenuService.deleteKomentar(komentar, widget.idToko, widget.idProduk)
                                  .whenComplete(() => Navigator.of(context).pop());
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(Icons.delete),
                  ),
                ),

                InkWell(
  onTap: () {
    TextEditingController _textFieldController = TextEditingController();
    _textFieldController.text = komentar.komentar.toString();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Komentar'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Masukkan komentar'),
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
                String editedComment = _textFieldController.text;
                // Lakukan pembaruan komentar di sini, misalnya dengan menggunakan MenuService.updateKomentar
                MenuService.updateKomentar(komentar, widget.idToko, widget.idProduk, editedComment)
                  .whenComplete(() => Navigator.of(context).pop());
              },
            ),
          ],
        );
      },
    );
  },
  child: const Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Icon(Icons.edit),
  ),
),

            ],
          )
          : null, // Jika bukan komentar dari pengguna saat ini, biarkan trailing null
      ),
    );
  },
);

        }
      },
    );
  }
}

class KomentarDialog extends StatefulWidget {
  final String id;
  final String idToko;
  const KomentarDialog({Key? key, required this.id, required this.idToko}) : super(key: key);

  @override
  State<KomentarDialog> createState() => _KomentarDialogState();
}

class _KomentarDialogState extends State<KomentarDialog> {
    final TextEditingController _komentarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Komentar'),
      
      content: TextField(
        controller: _komentarController,
        decoration: InputDecoration(hintText: 'Masukkan komentar...'),
        onChanged: (value) {
          // handle changes
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Batal'),
        ),
        TextButton(
          onPressed: () {
             String idUser = FirebaseAuth.instance.currentUser!.uid;
             Stream userStream = MenuService.getUser(idUser);

         userStream.listen((dynamic user) {

            String namaPengguna = user.nama;
            String imageUrl = user.imageUrl != null? user.imageUrl : "";
            MenuService.addKomentar(_komentarController.text, widget.id, widget.idToko, namaPengguna, imageUrl, idUser);
  },);

  
         Navigator.of(context).pop();

          },
          child: Text('Tambah'),
        ),
      ],
    );
  }
}


