import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/products/product.dart';
import 'package:ecommerce_app/screens/product_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final bool showDetails;
  final Product product;
  const ProductTile({
    super.key,
    required this.product,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.id,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
              elevation: 0,
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  navigatorPush(context, ProductScreen(product: product));
                },
                child: (product.imgUrl == null)
                    ? const Icon(
                        Icons.shopping_cart,
                        size: 200,
                      )
                    : CachedNetworkImage(
                        imageUrl: product.imgUrl!,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          if (showDetails)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.name ?? "This product doesn't have a name yet",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
