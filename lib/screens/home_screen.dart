import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CarouselItem>> _fetchCarouselItems(String collection) async {
    QuerySnapshot snapshot = await _firestore.collection(collection).get();
    return snapshot.docs.map((doc) => CarouselItem.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome, pelanggan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _buildCarousel('ads'),
            _buildCarousel('best_seller'),
            _buildCarousel('promo_menu'),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(String collection) {
    return FutureBuilder<List<CarouselItem>>(
      future: _fetchCarouselItems(collection),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No items found'));
        } else {
          return CarouselSlider(
            items: snapshot.data!.map((item) {
              return Image.network(item.imageUrl, fit: BoxFit.cover);
            }).toList(),
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          );
        }
      },
    );
  }
}

class CarouselItem {
  final String imageUrl;

  CarouselItem({required this.imageUrl});

  factory CarouselItem.fromMap(Map<String, dynamic> data) {
    return CarouselItem(
      imageUrl: data['imageUrl'],
    );
  }
}


