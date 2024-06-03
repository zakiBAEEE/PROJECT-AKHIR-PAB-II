import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/screens/detail_screen.dart';

class CardPromo extends StatefulWidget {
  final Menu menu;
  const CardPromo({super.key, required this.menu});

  @override
  State<CardPromo> createState() => _CardPromoState();
}

class _CardPromoState extends State<CardPromo> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(menu: widget.menu)),
        );
      },
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 85,
                  width: MediaQuery.of(context).size.width,
                  child: Ink.image(
                    image: NetworkImage("${widget.menu.imageUrl}"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    width: double.infinity,
                  )),
              if (widget.menu.isPromo)
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    " ON SALE 5%",
                    style: TextStyle(
                        color: Colors.white, backgroundColor: Colors.red),
                  ),
                )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
              child: Text(
            widget.menu.toko,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          )),
          SizedBox(
              child: Text(
            widget.menu.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            // child: ColorIndicatorView(product: product),
          ),
          Row(
            children: [
              Text(
                widget.menu.harga,
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
              ),
              if (true)
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Rp10.000',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                  ),
                ),
            ],
          ),
        ]),
      ),
    );
  }
}
