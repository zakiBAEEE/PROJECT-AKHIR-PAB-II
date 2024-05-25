import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';

class DetailPage extends StatefulWidget {
  final Menu menu;
  const DetailPage({super.key, required this.menu});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  // bool isSignIn = false; // Menyimpan status sign in

  @override
  void initState() {
    super.initState();
    // _checkSignInStatus();
  }

  // //Memeriksa status sign in
  // void _checkSignInStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool signedIn = prefs.getBool('isSignedIn') ?? false;
  //   setState(() {
  //     isSignIn = signedIn;
  //   });
  // }

  // Memeriksa status favorite

  Future<void> _toggleFavorite() async {
    bool favoriteStatus = !isFavorite;
    // Tambahkan pemanggilan untuk memperbarui tampilan Favorit

    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          const SizedBox(height: 20),
          header(),
          const SizedBox(height: 20),
          image(),
          details(),
        ],
      ),
    );
  }

  Container details() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.menu.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 34,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("Harga Menu"),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.menu.harga,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                width: 2,
                height: 30,
                color: Colors.black,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  const Text("Waktu Penyajian"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    " Menit",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 2,
                height: 30,
                color: Colors.black,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text("Waktu Tersedia"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.menu.jamBuka,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(Icons.shopping_bag),
                  SizedBox(width: 10,),
                  Text(
                    "Toko",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Row(
                children: [
                  Text(widget.menu.toko),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.map_outlined)
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Tentang ' + widget.menu.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.menu.description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  SizedBox image() {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.green[300]!,
                    blurRadius: 16,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(250),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(250),
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${widget.menu.imageUrl}"),
                      //whatever image you can put here
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Material(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            child: const BackButton(color: Colors.white),
          ),
          const Spacer(),
          Text(
            'Details Food',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          const Spacer(),
          Material(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    _toggleFavorite();
                  },
                  icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
