import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_wine/models/user.dart';
import 'package:red_wine/service/firebase.dart';


class EditFotoProfil extends StatefulWidget {
  final User user;
  const EditFotoProfil({super.key, required this.user});
  @override
  State<EditFotoProfil> createState() => _EditFotoProfilState();
}
class _EditFotoProfilState extends State<EditFotoProfil> {
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile Photo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Image: '),
              ),
              _imageFile != null
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: kIsWeb
                          ? CachedNetworkImage(
                              imageUrl: _imageFile!.path,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            )
                          : Image.file(File(_imageFile!.path),
                              fit: BoxFit.cover,),
                    )
                  : (widget.user.imageUrl != null &&
                          Uri.parse(widget.user.imageUrl!).isAbsolute
                      ? AspectRatio(
                          aspectRatio: 16 / 9,
                          child: CachedNetworkImage(
                            imageUrl: widget.user.imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        )
                      : Container()),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(
                height: 32.0,
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
                      String? imageUrl;
                      if (_imageFile != null) {
                        imageUrl = await MenuService.uploadImage(_imageFile!);
                      } else {
                        imageUrl = widget.user.imageUrl;
                      }
                      User pengguna = User(
                       nama: widget.user.nama,
                       email: widget.user.email,
                       idUser: widget.user.idUser,
                       imageUrl: imageUrl,
                       jenisUser: widget.user.jenisUser
                      );


                        MenuService.updateUser(pengguna)
                            .whenComplete(() => Navigator.of(context).pop());
                      
                    },
                    child: Text('Ganti Foto Profil'),
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