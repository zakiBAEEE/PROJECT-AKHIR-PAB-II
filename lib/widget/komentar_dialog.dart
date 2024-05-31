import 'package:flutter/material.dart';
import 'package:red_wine/service/firebase.dart';

class KomentarDialog extends StatefulWidget {
   final String idProduk;
   final String idToko;

  const KomentarDialog({super.key, required this.idProduk, required this.idToko});
  @override
  State<KomentarDialog> createState() => _KomentarDialogState();
}

class _KomentarDialogState extends State<KomentarDialog> {
  final TextEditingController _komentarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Row(
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
          onPressed: (){
            MenuService.addKomentar(_komentarController.text, widget.idProduk, widget.idToko);
             Navigator.pop(context);
            },
        ),
      ],
    ),
    );
  }
}
