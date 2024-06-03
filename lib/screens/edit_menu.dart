import 'package:flutter/material.dart';

class EditMenu extends StatefulWidget {
  const EditMenu({super.key});

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _jenisController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _tokoController = TextEditingController();
  final ValueNotifier<bool> _isFavorite = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isPromo = ValueNotifier<bool>(false);
  final TextEditingController _jamBuka = TextEditingController();
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Makanan'),
        backgroundColor: const Color.fromARGB(255, 7, 202, 128),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                    onPressed: () {
                      // Implementasi untuk memilih file
                    },
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
                  controller: _namaController,
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
                    'Toko',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _tokoController,
                  decoration: InputDecoration(
                    labelText: 'Toko',
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
                child: ElevatedButton(
                  onPressed: () {
                    // Implementasi untuk menambah makanan
                  },
                  child: Text(
                    'Edit Makanan',
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
