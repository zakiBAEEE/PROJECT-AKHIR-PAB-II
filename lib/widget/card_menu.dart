import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/screens/detail_screen.dart';

class CardMenu extends StatefulWidget {
  final Menu menu;
  final String id;
  final String idToko;

  const CardMenu({super.key, required this.menu, required this.id, required this.idToko});

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
              MaterialPageRoute(builder: (context) => DetailPage(menu: widget.menu, id: widget.id, idToko: widget.idToko,)),
            );
          },
      child: SizedBox(
        width: 100,
        height:100,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Ink.image(
                    image: NetworkImage(
                        "${widget.menu.imageUrl}"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    width: double.infinity,
                  )),
              if (widget.menu.isPromo)
              const  Padding(
                  padding:  EdgeInsets.all(4.0),
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
              child: Text(widget.menu.toko,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                 )),
          SizedBox(
              child: Text(widget.menu.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  )),
         const Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            // child: ColorIndicatorView(product: product),
          ),
          Row(
            children: [
              Text(widget.menu.harga,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                 ),
              if (true)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Rp10.000',
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
