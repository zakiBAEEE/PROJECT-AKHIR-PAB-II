import 'package:flutter/material.dart';
import 'package:red_wine/models/komentar.dart';

class ComentarScreen extends StatefulWidget {
  final List<Komentar> komentar;

  const ComentarScreen({super.key, required this.komentar});

  @override
  State<ComentarScreen> createState() => _ComentarScreenState();
}

class _ComentarScreenState extends State<ComentarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KOMENTAR"),
      ),
      body: widget.komentar != null && widget.komentar.isNotEmpty
          ? ListView.builder(
              itemCount: widget.komentar.length,
              itemBuilder: (context, index) {
                final komentar = widget.komentar[index];
                return ListTile(
                  title: Text(komentar.komentar.toString()),
                );
              },
            )
          : const Center(
              child: Text('No comments available'),
            ),
    );
  }
}
