
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
        id: widget.menu.id!,
        idToko: widget.menu.idToko!,
      ),
    );
  }
}

class ComentarList extends StatefulWidget {
  final String id;
  final String idToko;
  const ComentarList({Key? key, required this.id, required this.idToko,});

  @override
  State<ComentarList> createState() => _ComentarListState();
}

class _ComentarListState extends State<ComentarList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MenuService.getKomentarList(widget.id, widget.idToko),
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
            return ListView.builder(
              itemCount: komentarList.length,
              itemBuilder: (context, index) {
                final komentar = komentarList[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text(komentar.namaPengguna.toString()),
                    subtitle: Text(komentar.komentar.toString()),
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

         userStream.listen((dynamic haha) {

            String namaPengguna = haha.nama;
            MenuService.addKomentar(_komentarController.text, widget.id, widget.idToko, namaPengguna);
  },);

  
         Navigator.of(context).pop();

          },
          child: Text('Tambah'),
        ),
      ],
    );
  }
}


