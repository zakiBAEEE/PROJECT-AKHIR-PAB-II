import 'package:flutter/material.dart';
import 'package:red_wine/models/menu.dart';
import 'package:red_wine/service/firebase.dart';
import 'package:red_wine/widget/card_menu.dart';

class MenuScreen extends StatefulWidget {
  final String searchQuery;

  const MenuScreen({super.key, required this.searchQuery});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    print('Search Query: ${widget.searchQuery}'); // Debug print

    return StreamBuilder<List<Menu>>(
      stream: widget.searchQuery.isEmpty
          ? MenuService.getProdukList()
          : MenuService.searchMenus(widget.searchQuery),
      builder: (context, AsyncSnapshot<List<Menu>> snapshot) {
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

            var filteredData = snapshot.data!;
            print('Filtered Data: $filteredData'); // Debug print

            var makanan = filteredData
                .where((document) => document.jenis == 'makanan')
                .toList();
            var minuman = filteredData
                .where((document) => document.jenis == 'minuman')
                .toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (makanan.isNotEmpty) ...[
                      const Text(
                        'Makanan',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 300,
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: makanan.map((document) {
                          return CardMenu(menu: document);
                        }).toList(),
                      ),
                    ],
                    if (minuman.isNotEmpty) ...[
                      const SizedBox(height: 16.0), // Spasi antara bagian
                      const Text(
                        'Minuman',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 300,
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: minuman.map((document) {
                          return CardMenu(menu: document);
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
