import 'package:flutter/material.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Makanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gambar:',
              style: TextStyle(color: Colors.black),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implementasi untuk memilih file
                  },
                  child: Text('Choose File',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 10),
                Text(_imagePath ?? 'Pempek kulit.png'),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Makanan',
                style: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _hargaController,
              decoration: const InputDecoration(
                labelText: 'Harga',
                style: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _deskripsiController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implementasi untuk menambah makanan
                },
                child: const Text('Tambah Makanan',
                  style: TextStyle(color: Colors.black),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }

}