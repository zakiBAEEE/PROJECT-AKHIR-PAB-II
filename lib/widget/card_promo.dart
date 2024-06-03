import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/screens/detail_screen.dart';
import 'package:red_wine/widget/slashed_text.dart';

class CardPromo extends StatelessWidget {
  final Menu menu;
  const CardPromo({super.key, required this.menu});

  double calculateDiscountPrice(String harga) {
    // Remove non-numeric characters except for the comma
    String cleanedPrice = harga.replaceAll(RegExp(r'[^\d,]'), '');
    // Replace the comma with a dot to convert to a double
    cleanedPrice = cleanedPrice.replaceAll(',', '.');
    double originalPrice = double.parse(cleanedPrice);
    double discountPrice = originalPrice - (originalPrice * 0.2);
    return discountPrice;
  }

  @override
  Widget build(BuildContext context) {
    double discountedPrice = calculateDiscountPrice(menu.harga);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(menu: menu)),
        );
      },
      child: SizedBox(
        width: 160, // Adjusted width to fit the layout better
        height: 240, // Adjusted height to fit the layout better
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  height: 120, // Adjusted image height
                  width: MediaQuery.of(context).size.width,
                  child: Ink.image(
                    image: NetworkImage("${menu.imageUrl}"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    width: double.infinity,
                  ),
                ),
                if (menu.isPromo)
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      " ON SALE 20%",
                      style: TextStyle(
                          color: Colors.white, backgroundColor: Colors.red),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              menu.toko,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              menu.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SlashedText(
                  text: menu.harga,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    'Rp${discountedPrice.toStringAsFixed(0)}',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: const TextStyle(fontSize: 14, color: Colors.red),
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
