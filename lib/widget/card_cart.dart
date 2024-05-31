import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';

class CardCart extends StatefulWidget {
  final Menu menu;
  final String id;

  const CardCart({super.key, 
    required this.menu, 
    required this.id,
  });

  @override
  State<CardCart> createState() => _CardCartState();
}

class _CardCartState extends State<CardCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink.image(
              image:  NetworkImage(
                    "${widget.menu.imageUrl}"),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
    
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.menu.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.menu.toko,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                widget.menu.harga,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}