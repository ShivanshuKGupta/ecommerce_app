import 'package:ecommerce_app/models/products/product.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:ecommerce_app/widgets/dark_light_mode_icon_button.dart';
import 'package:ecommerce_app/widgets/product_tile.dart';
import 'package:ecommerce_app/widgets/select_many.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  bool featured = false;
  bool popular = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: const [
          DarkLightModeIconButton(),
        ],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 40),
          child: SelectMany(
            allOptions: const {
              'Featured',
              'Popular',
            },
            onChange: (chosenOptions) {
              setState(() {
                featured = chosenOptions.contains('Featured');
                popular = chosenOptions.contains('Popular');
              });
            },
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          key: UniqueKey(),
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: circularProgressIndicator());
            }
            products = snapshot.data!;
            print("featured = $featured");
            print("popular = $popular");
            products.retainWhere((element) {
              // print(
              //     "(featured == false ||(featured == true && element.isFeatured == true)) &&(popular == false ||(popular == true && element.isPopular == true)) = ${(featured == false || (featured == true && element.isFeatured == true)) && (popular == false || (popular == true && element.isPopular == true))}");
              return (featured == false ||
                      (featured == true && element.isFeatured == true)) &&
                  (popular == false ||
                      (popular == true && element.isPopular == true));
            });
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
