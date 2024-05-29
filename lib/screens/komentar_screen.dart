import 'package:flutter/material.dart';
import 'package:red_wine/service/firebase.dart';


class ComentarScreen extends StatefulWidget {
  final String id;

  const ComentarScreen({super.key, required this.id});

  @override
  State<ComentarScreen> createState() => _ComentarScreenState();
}

class _ComentarScreenState extends State<ComentarScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("KOMENTAR"),
        ),
        body: ComentarList(
          id: widget.id,
        ));
  }
}

class ComentarList extends StatefulWidget {
  
  final String id;
  const ComentarList({super.key, required this.id});

  @override
  State<ComentarList> createState() => _ComentarListState();
}

class _ComentarListState extends State<ComentarList> {
      final TextEditingController _komentarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: MenuService.getKomentarList(widget.id),
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
                          leading: const CircleAvatar(),
                          title: Text("User ${index + 1}"),
                          subtitle: Text(komentar.komentar.toString()),
                        ),
                      );
                    });
            }
          },
        ),
        Row(
      children: [
        Expanded(
          child: TextField(
            controller: _komentarController,
            decoration: InputDecoration(
              hintText: 'Tambahkan komentar...',
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.comment),
          onPressed: (){MenuService.addKomentar(_komentarController.text, widget.id);},
        ),
      ],
    )
      ],
    );
  }
}
