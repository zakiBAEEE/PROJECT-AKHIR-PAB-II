import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/screens/detail_screen.dart';
import 'package:red_wine/widget/slashed_text.dart';

class CardMenu extends StatefulWidget {
  final Menu menu;
  const CardMenu({super.key, required this.menu});

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(menu: widget.menu)),
        );
      },
      child: SizedBox(
        width: 160, // Adjusted width to fit the layout better
        height: 300, // Adjusted height to fit the layout better
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  height: 80, // Adjusted image height
                  width: MediaQuery.of(context).size.width,
                  child: Ink.image(
                    image: NetworkImage("${widget.menu.imageUrl}"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    width: double.infinity,
                  ),
                ),
                if (widget.menu.isPromo)
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      " ON SALE 5%",
                      style: TextStyle(
                          color: Colors.white, backgroundColor: Colors.red),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.menu.toko,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              widget.menu.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                SlashedText(
                  text: widget.menu.harga,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    'Rp10.000',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
