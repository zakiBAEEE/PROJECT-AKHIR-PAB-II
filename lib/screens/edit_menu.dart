import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/service/firebase.dart';

class EditMenu extends StatefulWidget {
  final Menu produk;
  const EditMenu({super.key, required this.produk});

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _jenisController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final ValueNotifier<bool> _isFavorite = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isPromo = ValueNotifier<bool>(false);
  final TextEditingController _jamBuka = TextEditingController();
  String? _imageUrl;
  XFile? _imageFile;

  void initState() {
    super.initState();
    if (widget.produk != null) {
      _imageUrl = widget.produk.imageUrl;
      _titleController.text = widget.produk.title;
      _hargaController.text = widget.produk.harga;
      _deskripsiController.text = widget.produk.description;
      _jenisController.text = widget.produk.jenis;
      _kategoriController.text = widget.produk.kategori;
      _isFavorite.value = widget.produk.isFavorite;
      _isPromo.value = widget.produk.isPromo;
      _jamBuka.text = widget.produk.jamBuka;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        _imageUrl = _imageFile!
            .path; // Update _imageUrl with the path of the selected image file
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Produk'),
        backgroundColor: const Color.fromARGB(255, 7, 202, 128),
        leading: IconButton(
          icon: const BackButton(
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text(
                      'Choose File',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    _imageUrl ?? 'Pempek kulit.png',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nama Makanan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Makanan',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Harga',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _hargaController,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _deskripsiController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jenis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _jenisController,
                  decoration: InputDecoration(
                    labelText: 'Jenis',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kategori',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _kategoriController,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Favorite?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  ValueListenableBuilder<bool>(
                      valueListenable: _isFavorite,
                      builder: (context, value, child) {
                        return DropdownButton(
                          value: value,
                          onChanged: (bool? newValue) {
                            _isFavorite.value = newValue!;
                          },
                          items: const [
                            DropdownMenuItem(
                              value: true,
                              child: Text("True"),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text("false"),
                            )
                          ],
                        );
                      })
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Promo?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  ValueListenableBuilder<bool>(
                      valueListenable: _isPromo,
                      builder: (context, value, child) {
                        return DropdownButton(
                          value: value,
                          onChanged: (bool? newValue) {
                            _isPromo.value = newValue!;
                          },
                          items: const [
                            DropdownMenuItem(
                              value: true,
                              child: Text("True"),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text("false"),
                            )
                          ],
                        );
                      })
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jam Buka',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _jamBuka,
                  decoration: InputDecoration(
                    labelText: 'Jam Buka',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    String idUser = FirebaseAuth.instance.currentUser!.uid;
                    Stream userStream = MenuService.getUser(idUser);

                    userStream.listen(
                      (dynamic user) async {
                        String namaPengguna = user.nama;
                        String tokoId = user.id;
                        // _imageUrl = await MenuService.uploadImage(_imageFile!);
                        Menu menu = Menu(
                            id: widget.produk.id,
                            title: _titleController.text,
                            description: _deskripsiController.text,
                            imageUrl: _imageUrl,
                            harga: _hargaController.text,
                            jamBuka: _jamBuka.text,
                            kategori: _kategoriController.text,
                            jenis: _jenisController.text,
                            isFavorite: _isFavorite.value,
                            isPromo: _isPromo.value,
                            toko: namaPengguna);

                        try {
                          await MenuService.updateProduk(tokoId, menu);
                          Navigator.of(context).pop();
                        } catch (error) {
                          print("Error updating product: $error");
                          // Handle error, display error message, etc.
                        }
                      },
                    );
                  },
                  child: Text(
                    'Edit Produk',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
