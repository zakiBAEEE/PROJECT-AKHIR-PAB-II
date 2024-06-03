import 'package:flutter/material.dart';
import 'package:red_wine/models/user.dart';
import 'package:red_wine/service/firebase.dart';

class TokoScreen extends StatefulWidget {
  const TokoScreen({super.key});

  @override
  State<TokoScreen> createState() => _TokoScreenState();
}

class _TokoScreenState extends State<TokoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Toko'),
      ),
      body: StreamBuilder(
        stream: MenuService.getAllToko(),
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
              // Mengakses data dari snapshot
              List<Pengguna> allToko = snapshot.data ?? [];

              // Gunakan data allToko di sini
              // Misalnya, tampilkan daftar toko:
              return ListView.builder(
                itemCount: allToko.length,
                itemBuilder: (context, index) {
                  Pengguna toko = allToko[index];
                  return ListTile(
                    title: Text(toko.nama),
                    subtitle: Text(toko.email),
                    // tambahkan fungsi lain yang sesuai dengan kebutuhan Anda
                  );
                },
              );
          }
        },
      ),
    );
  }
}
