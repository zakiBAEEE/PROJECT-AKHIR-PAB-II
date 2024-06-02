import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/models/user.dart';
import 'package:red_wine/service/firebase.dart';


class EditProfil extends StatefulWidget {
  final User user;


  const EditProfil({super.key, required this.user});


  @override
  State<EditProfil> createState() => _EditProfilState();
}


class _EditProfilState extends State<EditProfil> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _namaController.text = widget.user.nama;
      _emailController.text = widget.user.email;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nama ',
                textAlign: TextAlign.start,
              ),
              TextField(
                controller: _namaController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Description: ',
                ),
              ),
              TextField(
                controller: _emailController,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      User pengguna = User(
                        nama: _namaController.text,
                        email: _emailController.text,
                        jenisUser: widget.user.jenisUser,
                      ); 

                      MenuService.updateUser(pengguna);
                      },
                      
                    child: Text('Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}