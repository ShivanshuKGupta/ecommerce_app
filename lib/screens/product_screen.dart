import 'package:ecommerce_app/models/globals.dart';
import 'package:ecommerce_app/models/products/product.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:ecommerce_app/widgets/image_preview.dart';
import 'package:ecommerce_app/widgets/loading_elevated_button.dart';
import 'package:ecommerce_app/widgets/loading_icon_button.dart';
import 'package:ecommerce_app/widgets/product_tile.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late bool isFavorite;
  late bool isSaved;
  late bool isShopping;
  @override
  void initState() {
    super.initState();
    isFavorite = currentUser.favorites!.contains(widget.product.id);
    isSaved = currentUser.saved!.contains(widget.product.id);
    isShopping = currentUser.shopping!.contains(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(product.name!),
        actions: [
          LoadingIconButton(
            onPressed: () async {
              await currentUser.addRemoveToFavorites(widget.product.id);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_outlined,
              color: isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.product.imgUrl == null)
                const Icon(
                  Icons.shopping_cart,
                  size: 200,
                ),
              if (widget.product.imgUrl != null)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                      onTap: () {
                        navigatorPush(
                          context,
                          ImagePreview(
                            image: ProductTile(
                              showDetailsPage: false,
                              product: widget.product,
                              showDetails: false,
                            ),
                          ),
                        );
                      },
                      child: InteractiveViewer(
                          child: ProductTile(
                        showDetailsPage: false,
                        product: widget.product,
                        showDetails: false,
                      ))),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.product.name ?? "This product has no name yet",
                          style: textTheme(context).titleLarge,
                        ),
                        if (widget.product.isFeatured == true)
                          Text(
                            "Featured",
                            style: textTheme(context).bodySmall!.copyWith(
                                  color: colorScheme(context).primary,
                                ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.product.isPopular == true)
                    Card(
                      color: colorScheme(context).primary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Popular",
                          style: textTheme(context).titleSmall!.copyWith(
                                color: colorScheme(context).onPrimary,
                              ),
                        ),
                      ),
                    )
                ],
              ),
              const Divider(),
              Text(
                widget.product.description ??
                    "This product has no description yet",
                style: textTheme(context).titleSmall,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${(widget.product.price * 1.1).toStringAsFixed(2)}",
                  style: textTheme(context).titleSmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: colorScheme(context).onSurface.withOpacity(0.5),
                      ),
                ),
                Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  style: textTheme(context).titleLarge,
                ),
              ],
            ),
            LoadingElevatedButton(
              style: isShopping
                  ? ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).error,
                      foregroundColor: colorScheme(context).onError,
                    )
                  : null,
              onPressed: () async {
                await currentUser.addRemoveToCart(widget.product.id);
                setState(() {
                  isShopping = !isShopping;
                });
              },
              label: Text(isShopping ? 'Remove from Cart' : 'Add to Cart'),
              icon: Icon(isShopping
                  ? Icons.remove_shopping_cart_rounded
                  : Icons.add_shopping_cart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
