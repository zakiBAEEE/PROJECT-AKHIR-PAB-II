import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/service/firebase.dart';
import 'package:red_wine/widget/card_promo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MenuService.getProdukList(),
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
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            }
        }

        var promo = snapshot.data!
            .where((document) => document.isPromo)
            .toList();

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (promo.isNotEmpty) ...[
                  const Text(
                    'Best Seller',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 300,
                    child: Divider(
                      color: Colors.grey[400],
                    ),
                  ),
                  // Carousel Slider
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16/9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: promo.map((document) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.amber
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  document.title,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  document.toko,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                if (document.imageUrl != null)
                                  Material(
                                    child: Ink.image(
                                      image: NetworkImage(document.imageUrl!),
                                      fit: BoxFit.cover,
                                      width: 300,
                                      height: 200,
                                    )
                                  ),
                                
                                Text(
                                  document.harga,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const Text("Promo", style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 16.0), // Padding after carousel slider
                  GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    shrinkWrap: true, // Penting untuk menyesuaikan ukuran GridView dengan isinya
                    physics: const NeverScrollableScrollPhysics(), // Menghindari konflik scrolling dengan SingleChildScrollView
                    children: promo.map((document) {
                      return CardPromo(menu: document);
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}