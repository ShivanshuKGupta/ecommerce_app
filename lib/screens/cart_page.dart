import 'package:ecommerce_app/models/globals.dart';
import 'package:ecommerce_app/models/products/product.dart';
import 'package:ecommerce_app/providers/cart.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:ecommerce_app/widgets/loading_elevated_button.dart';
import 'package:ecommerce_app/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(ShoppingListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Shopping Cart'),
        actions: const [
          // DarkLightModeIconButton(),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          key: UniqueKey(),
          future: currentUser.fetchShoppingProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: circularProgressIndicator());
            }
            products = snapshot.data!;
            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Choose a product to add to cart.',
                      textAlign: TextAlign.center,
                      style: textTheme(context).bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              );
            }
            return Scaffold(
              body: Padding(
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
                    children: products.map(
                      (product) {
                        return ProductTile(product: product);
                      },
                    ).toList(),
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                            'Total: \$${products.fold(0.0, (previousValue, element) => previousValue + element.price).toStringAsFixed(2)}'),
                      ),
                      LoadingElevatedButton(
                        onPressed: () async {
                          showMsg(context, 'In Development');
                        },
                        icon: const Icon(Icons.shopping_cart_checkout_rounded),
                        label: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
