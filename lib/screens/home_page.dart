import 'package:ecommerce_app/models/products/product.dart';
import 'package:ecommerce_app/utils/dark_light_mode_icon_button.dart';
import 'package:ecommerce_app/utils/product_tile.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    bool gridView = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Catalog'),
        actions: const [
          DarkLightModeIconButton(),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          key: UniqueKey(),
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: circularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    products = [];
                  });
                },
                child: GridView.extent(
                  key: UniqueKey(),
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: snapshot.data!.map(
                    (product) {
                      return ProductTile(product: product);
                    },
                  ).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
