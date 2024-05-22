import 'package:flutter/material.dart';

class CardMenu extends StatefulWidget {
  const CardMenu({super.key});

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Ink.image(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/notes-984be.appspot.com/o/images%2F1000000033.jpg?alt=media&token=8c03c679-983e-444a-9747-cb38d6f5175a"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  width: double.infinity,
                )),
            if (true)
              Padding(
                padding: const EdgeInsets.all(4.0),
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
            child: Text('Pempek Piko',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: Theme.of(context).textTheme.caption)),
        SizedBox(
            child: Text('Pempek Keriting',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyText2)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          // child: ColorIndicatorView(product: product),
        ),
        Row(
          children: [
            Text('Rp7.000,00',
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.orange[400])),
            if (true)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Rp10.000',
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(decoration: TextDecoration.lineThrough)),
              ),
          ],
        ),
      ]),
    );
  }
}
